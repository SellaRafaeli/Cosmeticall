$quotes = $mongo.collection('quotes')

LOCATION_CHANGE_LEVEL_ONE   = 0.01
LOCATION_CHANGE_LEVEL_TWO   = 0.1
LOCATION_CHANGE_LEVEL_THREE = 1

get '/quotes/all' do
 quotes = $quotes.all
 {quotes:quotes}
end 

post '/create_quote' do 
 		# find users around according to lat and long, + treatments + home visits
 		treatments = params['treatments'][0].present? ? params['treatments'] : ["Any treatment"]
 		latitude =  params['latitude'].present? ? params['latitude'] : cu['latitude'].to_s
 		longitude =  params['longitude'].present? ? params['longitude'] : cu['longitude'].to_s
 		sellers_sent_to = get_users_around(latitude, longitude, treatments, params[:at_home])  

		quote  = $quotes.add({
		buyer_name:cu[:name], 
		buyer_phone: cu[:phone],
		sellers_sent_to: sellers_sent_to,
		month:params['month'],
 		day:params['day'],
 		time_from:params['time_from'],
 		time_to:params['time_to'],
		at_home:params['at_home'],
		latitude:latitude.to_f,
		longitude:longitude.to_f,
		treatments:treatments,
		address:params['address'],
		answered_sellers:[]})


		general_text = create_text(cu['name'], 
					params[:day], 
					params[:month], 
					params[:time_from], 
					params[:time_to], 
					params[:at_home], 
					params[:treatments], 
					params[:address])

		link = $root_url + "/answer_quote?_id=" + quote["_id"]
		text = "Hello! " + general_text + ". To answer, follow link " + link
		 
		sellers_sent_to.each {|user| send_sms(user['phone'], text, "send_quote", cu["phone"])} 

		{quote:quote} 
end


get '/answer_quote' do
	quote_id = params[:_id]
	quote = $quotes.get(_id:quote_id)
	if !quote
		full_page_card(:"other/404")  
	else
		text = create_text(quote[:buyer_name], 
						   quote[:day], quote[:month], 
							quote[:time_from], 
							quote[:time_to], 
							quote[:at_home], 
							quote[:treatments], 
							quote[:address])
		full_page_card(:"answer_quote", locals: {quote_id: params['_id'], text: text })
	end
end



get '/answer_seller' do
	# when seller sends answer to a quote, buyer gets link that forwards him to this page
	# here he can answer the seller

	quote_id = params[:_id]
	quote = $quotes.get(_id:quote_id)
	if !quote
		full_page_card(:"other/404")  
	else
		text = create_text(quote[:buyer_name], 
						   quote[:day], quote[:month], 
						   quote[:time_from], 
						   quote[:time_to], 
						   quote[:at_home], 
						   quote[:treatments], 
						   quote[:address])
	end

  	full_page_card(:"answer_seller", locals: {quote_id: params['_id'], text: text })
end

post '/answer_quote' do
	quote_id = params[:quote_id]
	quote = $quotes.get(_id:quote_id) 

  	seller_phone =  params[:phone] || cu[:phone]
  	sellers_sent_to = quote[:sellers_sent_to].map {|user| user[:phone] }
  	
  	if seller_phone.in?(quote[:answered_sellers])
  		flash.message = "You already answered this quote request."
  		redirect "/"
  	else

		link = $root_url + "/answer_seller?_id=" + quote_id + "&seller_phone=" + seller_phone

		buyer_phone = quote[:buyer_phone] || "972549135125"
		if seller_phone.in?(sellers_sent_to)
				sellers_sent_to.each { |user_phone|
					
					seller_name =  $users.get(phone:user_phone)["name"]
					text = "Hi! #{seller_name} sent you following message: #{params[:description]}, he is offering price of #{params[:price]}. To answer, follow this link #{link}, or call #{seller_name} at #{user_phone}"
					send_sms(buyer_phone, text, "answer_quote", seller_phone)
				}

				$quotes.find_one_and_update({_id: params[:quote_id]}, {'$push' => {answered_sellers: seller_phone}})    

				flash.message = "You message has been successfully sent!"
				redirect "/"

		else	
			url = $root_url + "/contact_us"
			
			# <a href="<=% url %>">support</a>
			
			flash.message = "Your phone number was not requested by this user. Please talk to our " + '<a href="' + url + '">support</a>'
			redirect back
		end
	end
end

post '/answer_seller' do
	quote_id = params[:quote_id]
	quote = $quotes.get(_id:quote_id)

	seller_phone = params[:seller_phone] 
  	buyer_phone =  params[:phone] || cu[:phone]
  	buyer_name = quote[:buyer_name]
  	
  	text = "Hi! #{buyer_name} sent you following message: #{params[:description]}. You can call #{buyer_name} at #{buyer_phone} to schedule a meeting!"
  	send_sms(seller_phone, text, "answer_seller", buyer_phone)
	flash.message = "You message has been successfully sent!"
	redirect "/"
end

def get_users_around_coordinates(lat, lng, offset, additional_params, home_visits)
	# searches by users around requested address that perform requested treatments
	 additional_params ||= {}
	 if home_visits == "true"
	 $users.find({ latitude: {"$gte": lat.to_f - offset, "$lte": lat.to_f + offset},
	 	longitude: {"$gte": lng.to_f - offset, 
		"$lte": lng.to_f + offset}, 
		treatments: {:$in=>additional_params},
		home_visits: home_visits}).to_a
	else
		$users.find({ latitude: {"$gte": lat.to_f - offset, "$lte": lat.to_f + offset},
	 	longitude: {"$gte": lng.to_f - offset, 
		"$lte": lng.to_f + offset}, 
		treatments: {:$in=>additional_params}}).to_a
	end

end


def get_users_around(lat, lng, additional_params, home_visits)
	items_level1, items_level2, items_level3 = [], [], []

	items_level1 = get_users_around_coordinates(lat, lng, LOCATION_CHANGE_LEVEL_ONE, additional_params, home_visits)

	if items_level1.size < 10
		items_level2 = get_users_around_coordinates(lat, lng, LOCATION_CHANGE_LEVEL_TWO, additional_params, home_visits)
	end

	if items_level2.size < 10
		items_level3 = get_users_around_coordinates(lat, lng, LOCATION_CHANGE_LEVEL_THREE, additional_params, home_visits)
	end

	items = (items_level1 + items_level2 + items_level3).uniq
	items
end


def create_text(buyer_name, day, month, time_from, time_to, at_home, treatments, address)
	if day != "Any day" && month != "Any month"

			day_month =  "on " + day + "/" + month + "/2016"
		else
			day_month = "any day,"
		end
		
		if time_from != "Any time"
			from_to = 'from ' + time_from + " to " + time_to
		else
			from_to = "anytime"
		end
			
		if at_home == "true"
			at_home = "at #{address}"
		else
			at_home = "at your office"
		end
		treatments_list = (treatments || []).split(",").join(", ") 

	text = "#{buyer_name} wants #{treatments_list} #{at_home} #{day_month} #{from_to}"
end
