$users = $mongo.collection('users')

get '/signup' do
  full_page_card(:"users/signup_form") #, locals: {})
  #erb :"users/sign_up_form", layout: :layout 
end

get '/logout' do
  log_event('logged out')
  session.clear
  redirect '/login'
end

post '/create_user' do
	bp
	user = $users.add({name: params['name'],
		profession: params['profession'],
   		address: params['address'],
    	city: params['city'],
   		description: params['description'],
   		treatments: params['treatments'],
   		home_visits: params['home_visits']})

	{user:user} 
end
=begin
The registration page should be reached by going to /sign_up. This page will have a header ("Sign Up") and one form. The form will have the following fields for now: 
- Name (single line input)
- Profession (dropdown out of a constant list)
- Address (single line input)
- City (dropdown out of a constant list)
- Description (textarea)
- Treatments they do (multi-select)
- Whether they do home visits (checkbox)

All the fields are required (used HTML's "required" attribute).
Include a submit button. Submitting the form will create a user with that data.

Don't worry too much about styling for now.
=end