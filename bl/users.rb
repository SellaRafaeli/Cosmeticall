$users = $mongo.collection('users')

DEFAULT_WOMAN_PIC_URL = '/img/default_woman.png'

get '/signup/client' do
  full_page_card(:"users/signup_form", locals: {seller: false})
end

get '/signup/seller' do
  full_page_card(:"users/signup_form", locals: {seller: true})
end

get '/update_me' do
  if cu[:profession]
    full_page_card(:"users/signup_form", locals: {update_user: true, seller: true})
  else
    full_page_card(:"users/signup_form", locals: {update_user: true})
  end
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
  phone         = clean_params_phone
	user = $users.get(phone: phone)
	if user
		flash.message = 'User with this phone number already exists, please log in' 
	else
    token =  rand(10000)+1000  
    address = params['address'].split(",")[0..-2].join(",")  
		user  = $users.add({name: params['name'],
    token: token.to_s,
		phone: phone,
		profession: params['profession'],
    pic_url: params['pic_url'].present? ? params['pic_url'] : DEFAULT_WOMAN_PIC_URL,
 		address: address,
    latitude: params['latitude'].to_f,
    longitude: params['longitude'].to_f,
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
  #(expects one or more of the following and sets it: [treatments, address, email, pic_url, name.] 
  user = $users.find_one_and_update({_id: cuid}, {'$set' => params.except(:id)}) 
  flash.message = 'Your info was updated!'
  redirect back
end



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
  send_sms(user['phone'], text, "login") 
 
  flash.message = "Message sent to #{phone} with a Magic Link to sign in :)"
  redirect back

end
get '/log_in' do
   full_page_card(:"users/login", locals: {user:cu})
end



