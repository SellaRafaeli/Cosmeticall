$users = $mongo.collection('users')

get '/signup' do
  full_page_card(:"users/signup_form") #, locals: {})
  #erb :"users/sign_up_form", layout: :layout 
end

get '/logout' do
  log_event('logged out')
  session.clear
  redirect '/'
end

post '/create_user' do
  phone_number = params['code']+params['phone_without_code']
  phone = phone_number.gsub(/\s+/, "").gsub(/-/, "")
	existing_user = $users.get(phone: phone)
	if existing_user
		flash.message = 'User with this phone number already exists, please log in' 
	else
		user = $users.add({name: params['name'],
		phone: phone,
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

get '/update_user' do
  $users.find_one_and_update({_id: cuid}, {'$set' => params.except(:id)}) 
  {user:cu}
  #(expects one or more of the following and sets it: [paypal_email, email, pic_url, name.] 
end

#http://localhost:9292/login?token=8938019
get '/login' do
  #token="12983012938"
  flash.message = "Welcome back!"
  existing_user = $users.get(token: params[:token])
    if existing_user #user already exists, sign him in
        session[:user_id] = existing_user['_id']
        redirect '/'
  else
    flash.message = "No such user."
    redirect '/'
    #halt_bad_input(msg: 'phone or token are missing/incorrect')
  end

end