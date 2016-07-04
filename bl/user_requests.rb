$user_requests = $mongo.collection('user_requests')

post '/contact_supplier_ajax' do
  	phone_number = params['code']+params['phone_without_code']
  	phone = phone_number.gsub(/\s+/, "").gsub(/-/, "")
  	user_request = $user_requests.add({phone: phone,
  					description: params[:description]})
  	{user_request:user_request}
end
