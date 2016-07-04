$user_messages = $mongo.collection('user_messages')

post '/contact_supplier_ajax' do
  	phone_number = params['code']+params['phone_without_code']
  	phone = phone_number.gsub(/\s+/, "").gsub(/-/, "")
  	user_message = $user_messages.add({phone: phone,
  					description: params[:description]})
  	{user_message:user_message}
end
