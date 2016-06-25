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

# get '/card' do
#   full_page_card(:"other/about")
# end

# get '/page' do
#   to_page(:"other/about")
# end