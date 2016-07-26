
post '/search_ajax' do
	#search by regex
	#sleep(0.3) if !$prod
	criteria = {}
	
	criteria[:name] = {"$regex" => Regexp.new(params[:name], Regexp::IGNORECASE) } if params[:name].present?
	criteria[:city] = params[:city] if params[:city].present?
	# criteria[:treatments]  = params[:treatments] if params[:treatments][0].present?

	criteria[:treatments]  = { '$in': params[:treatments] } if params[:treatments][0].present?
	criteria[:home_visits] = 'true' if (params[:home_visits].to_s == 'true')
	
	users       = $users.get_many(criteria).sample(50).sort_by {|u| u[:create_at]}
    users = users.each  { |user| 
    	user["treatments"]  = (user["treatments"] || []).split(",").join(", ") 
    	user["home_visits"] = "Performs home visits" if user["home_visits"]
    	users
    }

  {users:users}


end

get '/search' do
  erb :"search/search", default_layout 
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

