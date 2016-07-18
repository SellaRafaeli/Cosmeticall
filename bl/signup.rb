$users = $mongo.collection('users')

DEFAULT_WOMAN_PIC_URL = '/img/default_woman.png'

get '/signup' do
  full_page_card(:"users/signup_form") #, locals: {})
  #erb :"users/sign_up_form", layout: :layout 
end

get '/logout' do
  log_event('logged out')
  session.clear
  redirect '/'
end

def clean_params_phone
  params[:phone].gsub('(','').gsub(')','').gsub(' ','').gsub('-','')
end

post '/create_user' do
  # phone_number = params['code']+params['phone_without_code']
  #phone = phone_number.gsub(/\s+/, "").gsub(/-/, "")

  phone         = clean_params_phone
	existing_user = $users.get(phone: phone)
	if existing_user
		flash.message = 'User with this phone number already exists, please log in' 
	else
    token =  rand(10000)+1000    
		user  = $users.add({name: params['name'],
    token: token.to_s,
		phone: phone,
		profession: params['profession'],
    pic_url: DEFAULT_WOMAN_PIC_URL,
 		address: params['address'],
    latitude: params['latitude'],
    longitude: params['longitude'],
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

post '/login' do
  phone =  clean_params_phone 
  user  =  $users.get(phone: phone)
  if !user
    flash.message = "No user found with phone: #{phone}"
    redirect back
  end
  
  token =  (rand(10000)+1000).to_s
  user  = $users.find_one_and_update({_id: user["_id"]}, {'$set' => {token:token}}) 
  link  = "#{$root_url}/login?phone=#{user['phone']}&token=#{token}"
  text  = "Click here to enter Cosmeticall: #{link}"
  send_sms(user['phone'], text)
  flash.message = "Message sent to #{phone} with a Magic Link to sign in. :)"
  redirect back
  # bp
  #redirect "#{link}"
  # redirect '/log_in
end
get '/log_in' do
   full_page_card(:"users/login", locals: {user:cu})
end

