$user_requests = $mongo.collection('user_requests')

post '/search_ajax' do
	def search_by(field, val, opts={})

    crit = {field => {"$regex" => Regexp.new(val, Regexp::IGNORECASE) } } 
    get_many(crit, opts)
	end

	#search by regex
	name_regex = {"name" => {"$regex" => Regexp.new(params[:name], Regexp::IGNORECASE) } } 
	users = $users.get_many(name_regex.merge({treatments:params[:treatments], city:params[:city]})) 
	 
	#sleep(0.4) if !$prod
    # users = $users.get_many({treatments:params[:treatments], city:params[:city]}) 
	{users:users}
end

get '/search' do
  erb :"search/search", default_layout #full_page_card(:"search/search")
end 





 #  if params[:description]
	# 	items = $users.search_by("description", params[:description])
	# elsif params[:name]
	# 	items = $users.get({name:params[:name]}) 
	# elsif params[:phone]
	# 	items = $users.get({phone:params[:phone]}) 
	# elsif params[:city]
	# 	items = $users.get_many({city:params[:city]}, sort: [{created_at: -1}] )
	# elsif params[:treatments]
	# 	items = $users.get_many({treatments:params[:treatments]}, sort: [{created_at: -1}] )
	# else
	# 	items = $users.get_many({})
	# end

