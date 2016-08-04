$contact_supplier = $mongo.collection('contact_supplier')


post '/contact_supplier_ajax' do
    if cu
      sender_phone = cu['phone']
    else
  	  sender_phone = clean_params_phone
    end
    supplier_phone = params[:supplier_phone].gsub('(','').gsub(')','').gsub(' ','').gsub('-','')

    body         = params[:description]
    text = "You have a new message from #{sender_phone}: #{body}"
  	$contact_supplier.add({sender_phone:sender_phone,
  					                           description: body, 
  					                           receiver_phone:supplier_phone,
                                       type:"contact_supplier"})
    
    send_sms(supplier_phone, text, "contact_supplier", sender_phone) 
end

get '/contact_supplier/all' do
	contact_supplier = $contact_supplier.all
	{contact_supplier:contact_supplier}
end

get '/my_requests' do
	requests_by_me = $contact_supplier.get_many(phone: cu[:phone], type: "contact_supplier")
	requests_to_me = $contact_supplier.get_many(supplier_phone: cu[:phone], type: "contact_supplier")
	{user_phone:cu[:phone], requests_by_me:requests_by_me, requests_to_me:requests_to_me}
end



get '/me' do
	{cu:cu}
end
