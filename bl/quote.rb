$quotes = $mongo.collection('quotes')

LOCATION_CHANGE_LEVEL_ONE   = 0.01
LOCATION_CHANGE_LEVEL_TWO   = 0.1
LOCATION_CHANGE_LEVEL_THREE = 1

get '/quotes/all' do
  quotes = $quotes.all
  {quotes:quotes}
end 


def get_users_around_coordinates(lat, lng, offset, additional_params)
	# searches by users around requested addressm that perform requested treatments
	 additional_params ||= {}
	 $users.find({ latitude: {"$gte": params[:latitude].to_f - offset, "$lte": params[:latitude].to_f + offset},
	 	longitude: {"$gte": params[:longitude].to_f - offset, 
		"$lte": params[:longitude].to_f + offset}, 
		treatments: {:$in=>additional_params}}).to_a
end


def get_users_around(lat, lng, additional_params)	
	items_level1, items_level2, items_level3 = [], [], []

	items_level1 = get_users_around_coordinates(lat, lng, LOCATION_CHANGE_LEVEL_ONE, additional_params)

	if items_level1.size < 10
		items_level2 = get_users_around_coordinates(lat, lng, LOCATION_CHANGE_LEVEL_TWO, additional_params)
	end

	if items_level2.size < 10
		items_level3 = get_users_around_coordinates(lat, lng, LOCATION_CHANGE_LEVEL_THREE, additional_params)
	end

	items = (items_level1 + items_level2 + items_level3).uniq
	items
end

# test function 
post '/add_sms' do 
		
		treatments = [params["treatments"]]
		
		#users_sent_to = get_users_around(params['latitude'], params['longitude'], params["treatments"]) 
		users_sent_to = get_users_around(params['latitude'], params['longitude'], treatments) 

		if params['day'] != "Any day" && params['month'] != "Any month"

			day_month =  "on " + params['day'] + "/" + params['month'] + "/2016"
		else
			day_month = ""
		end
		
		if params['time_from'] != "Any time"
			from_to = 'from ' + params['time_from'] + " to " + params['time_to'] 
		else
			from_to = ""
		end
			
		to = #{user['time_to']}
		if params['at_home']
			at_home = "at #{params['address']}"
		else
			at_home = "at your office"
		end

		#{user['name']}
		text =  "Hello! #{cu['name']} wants #{params['treatments']} #{at_home} #{day_month} #{from_to}" 

		users_sent_to.each {|user| send_sms(user['phone'], text, "send_quote", cu["phone"])}
		{sms:sms} 
	end



post '/create_quote' do 
 		# find users around lat and long, + home visits

 		users_sent_to = get_users_around(params['latitude'], params['longitude'], params["treatments"]) #$users.random

		quote  = $quotes.add({
		users_sent_to: users_sent_to,
		month:params['month'],
 		day:params['day'],
 		time_from:params['time_from'],
 		time_to:params['time_to'],
		at_home:params['at_home'],
		latitude:params['latitude'].to_f,
		longitude:params['longitude'].to_f,
		treatments:params['treatments'],
		address:params['address']})


		
		users_sent_to = get_users_around(params['latitude'], params['longitude'], params["treatments"]) 


		if params['day'] != "Any day" && params['month'] != "Any month"

			day_month =  "on " + params['day'] + "/" + params['month'] + "/2016"
		else
			day_month = "any day,"
		end
		
		if params['time_from'] != "Any time"
			from_to = 'from ' + params['time_from'] + " to " + params['time_to'] 
		else
			from_to = "anytime"
		end
			
		if params['at_home'] == "true"
			at_home = "at #{params['address']}"
		else
			at_home = "at your office"
		end
		treatments = (params["treatments"] || []).split(",").join(", ") 
		text =  "Hello! #{cu['name']} wants #{treatments} #{at_home} #{day_month} #{from_to}" 
		# text =  "Hello, #{user['name']}! #{cu['name']} wants #{params['treatments']} #{at_home} #{day_month}" 

		users_sent_to.each {|user| send_sms(user['phone'], text, "send_quote", cu["phone"])} 

		{quote:quote} 
end


# post '/quote_ajax' do
# 	#search by regex
# 	#sleep(0.3) if !$prod
# 	criteria = {}
	
# 	criteria[:name] = {"$regex" => Regexp.new(params[:name], Regexp::IGNORECASE) } if params[:name].present?
# 	criteria[:city] = params[:city] if params[:city].present?
# 	criteria[:treatments]  = params[:treatments] if params[:treatments].present?
# 	criteria[:home_visits] = 'true' if (params[:home_visits].to_s == 'true')
	
# 	users       = $users.get_many(criteria).sample(50).sort_by {|u| u[:create_at]}
#     # users = $users.get_many({treatments:params[:treatments], city:params[:city]}) 
#     users = users.each  { |user| 
#     	user["treatments"]  = (user["treatments"] || []).split(",").join(", ") 
#     	user["home_visits"] = "Performs home visits" if user["home_visits"]
#     	users
#     }
#   {users:users}