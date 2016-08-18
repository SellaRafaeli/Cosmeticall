$contact_us = $contact = $mongo.collection('contact_us')

get '/contact_us' do
 full_page_card(:"contact_us/contact_form")
end

post '/contact_us' do
	data = {text: params['text'], phone: params['phone'], 
			name: params['name']}
	$contact_us.add(data)
	flash.message = t("message_sent") + " " + t("will_get_back_to_you")
	redirect "/"
end

