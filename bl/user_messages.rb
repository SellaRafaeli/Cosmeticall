$user_messages = $mongo.collection('user_messages')

post '/contact_supplier_ajax' do
    if cu
      sender_phone = cu['phone']
    else
  	  sender_phone = clean_params_phone
    end
    body         = params[:description]
  	user_message = $user_messages.add({sender_phone:sender_phone,
  					description: body, 
  					receiver_phone: params[:supplier_phone]})
  
    text = "You have a new message from #{sender_phone}:\n #{body}"
    send_sms(params[:supplier_phone], text) 
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
