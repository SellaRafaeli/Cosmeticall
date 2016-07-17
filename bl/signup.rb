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
  # phone_number = params['code']+params['phone_without_code']
  #phone = phone_number.gsub(/\s+/, "").gsub(/-/, "")
	existing_user = $users.get(phone: params[:phone])
	if existing_user
		flash.message = 'User with this phone number already exists, please log in' 
	else
    token =  rand(10000)+1000
		user = $users.add({name: params['name'],
    token:token.to_s,
		phone: params[:phone],
		profession: params['profession'],
   		address: params['address'],
    	city: params['city'],
   		description: params['description'],
   		treatments: params['treatments'],
   		home_visits: params['home_visits']})
   		end
		session[:user_id] = user['_id']
		{user:user} 
	flash.message = 'Welcome '+params['name']+'!'
  redirect '/'
end

post '/update_user' do

  user = $users.find_one_and_update({_id: cuid}, {'$set' => params.except(:id)}) 
  flash.message = 'Updated.'
  redirect back
  #{user:user}
  #(expects one or more of the following and sets it: [paypal_email, email, pic_url, name.] 
end

get '/update_me' do
  full_page_card(:"users/signup_form", locals: {update_user: true})
  #(expects one or more of the following and sets it: [paypal_email, email, pic_url, name.] 
end


#http://localhost:9292/login?token=8938019
get '/login' do
  #token="12983012938"
  existing_user = $users.get(token: params[:token]) || nil
  
  if existing_user #user already exists, sign him in
        flash.message = "Welcome back #{existing_user['name']}!"
        session[:user_id] = existing_user['_id']
        redirect '/'
  else
    flash.message = "No such user."
    redirect '/log_in'
    #halt_bad_input(msg: 'phone or token are missing/incorrect')
  end

end

def send_sms(phone,link)
  
end

post '/login' do
  user = $users.get(phone: params[:phone])
  token =  (rand(10000)+1000).to_s
  user = $users.find_one_and_update({_id: user["_id"]}, {'$set' => {token:token}}) 
  link = "#{$root_url}/login?phone=#{user['phone']}&token=#{token}"
  send_sms(user['phone'], link)
  flash.message = 'Message sent! Check your SMS inbox :)'
  # bp
  redirect "#{link}"
  # redirect '/log_in'

  

end
get '/log_in' do
   full_page_card(:"users/login", locals: {user:cu})
end

