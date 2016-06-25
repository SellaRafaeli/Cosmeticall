$users = $mongo.collection('users')

get '/signup' do
  full_page_card(:"users/signup_form") #, locals: {})
  #erb :"users/sign_up_form", layout: :layout 
end

get '/logout' do
  log_event('logged out')
  session.clear
  redirect '/login'
end

post '/create_user' do
	existing_user = $users.get(phone: params[:phone])
	if existing_user
		flash.message = 'User with this phone number already exists, please log in' 
	else
		user = $users.add({name: params['name'],
		phone: params['phone'],
		profession: params['profession'],
   		address: params['address'],
    	city: params['city'],
   		description: params['description'],
   		treatments: params['treatments'],
   		home_visits: params['home_visits']})
   		end
		session[:user_id] = user['_id']
		{user:user} 
	
end
