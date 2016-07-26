$quotes = $mongo.collection('quotes')

get '/quotes/all' do
  quotes = $quotes.all
  {quotes:quotes}
end 


post '/create_quote' do 
 		# find users around lat and long, + home visits
 		users_sent_to = $users.random # for now return random user
		quote  = $quotes.add({
		users_sent_to: users_sent_to,
		month:params['month'],
 		day:params['day'],
 		time_from:params['time_from'],
 		time_to:params['time_to'],
		at_home:params['at_home'],
		latitude:params['latitude'],
		longitude:params['longitude'],
		treatments:params['treatments'],
		address:params['address']})

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