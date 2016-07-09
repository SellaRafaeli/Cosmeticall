 $user_messages = $mongo.collection('user_messages')

post '/contact_supplier_ajax' do
  	phone_number = params['code']+params['phone_without_code']
  	phone = phone_number.gsub(/\s+/, "").gsub(/-/, "")
  	user_message = $user_messages.add({sender_phone: phone,
  					description: params[:description], 
  					receiver_phone: params[:supplier_phone]})
  	bp
  	{user_message:user_message}
end

get '/user_messages/all' do
	user_messages = $user_messages.all
	{user_messages:user_messages}
end


get '/my_requests' do
	requests_by_me = $user_messages.get_many(phone: cu[:phone])
	requests_to_me = $user_messages.get_many(supplier_phone: cu[:phone])
	{user_phone:cu[:phone], requests_by_me:requests_by_me, requests_to_me:requests_to_me}
end

get '/me' do
	{cu:cu}
end
