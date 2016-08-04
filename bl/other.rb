get '/about' do 
  full_page_card(:"other/about")
end 

get '/' do
  redirect '/search'
end

get '/users/all' do
	users = $users.all
	{users: users}
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

