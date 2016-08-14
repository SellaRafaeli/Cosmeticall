get '/texts' do 
	redirect '/'
end

# <%=t('')%>

TREATMENTS = {
  manicure: ['manicure_sub_option_1', 'manicure_sub_option_2', 'manicure_sub_option_3', 'manicure_sub_option_4'],
  pedicure: ['pedicure_sub_option_1', 'pedicure_sub_option_2', 'pedicure_sub_option_3', 'pedicure_sub_option_4'],
  hair_treatment: ['hair_treatment_sub_option_1', 'hair_treatment_sub_option_2', 'hair_treatment_sub_option_3', 'hair_treatment_sub_option_4']
}

PROFESSIONS = ['beautician','cosmetician','doctor', 'hairdresser']
CITIES = ["tel_aviv", "haifa", "ashdod", "beer_sheva"]

TEXTS = {
	# search page

	anywhere: {
		he: 'xxxxx',
		en: 'Anywhere'
	},

	found: {
		he: 'xxxxx',
		en: 'Found'
	},

	users: {
		he: 'xxxxx',
		en: 'users'
	},

	treatment_type: {
		he: 'xxxxx',
		en: 'Treatment Type'
	},

	treatment: {
		he: 'xxxx',
		en: 'Treatment'
	},

	
	area: {
		he: 'xxxx',
		en: 'Area'
	},

	home_visits: {
		he: 'xxxx',
		en: 'Home visits'
	},

	tel_aviv: {
		he: 'xxxx',
		en: 'Tel Aviv'
	},

	haifa: {
		he: 'xxxx',
		en: 'Haifa'
	},

	ashdod: {
		he: 'xxxx',
		en: 'Ashdod'
	},

	beer_sheva: {
		he: 'xxxx',
		en: 'Beer Sheva'
	},

#buttons
			search: {
		he: 'xxxx',
		en: 'Search'
	},
# stuff

	sign_in_as_user: {
		he: 'xxxx',
		en: 'Sign in as user'
	},

	found_users: {
		he: 'xxxx',
		en: 'Found users'
	},

	send_sms: {
		he: 'xxxx',
		en: 'Send sms'
	},

	send: {
		he: 'xxxx',
		en: 'Send'
	},

	
	#get_quote page
	get_quote: {
		he: 'הצעת מחיר',
		en: 'Get Quote'
	},


	my_phone_number: {
		he: 'xxxx',
		en: 'My Phone Number'
	},

	month: {
		he: 'xxxx',
		en: 'Month'
	},

	day: {
		he: 'xxxx',
		en: 'Day'
	},

	time_from: {
		he: 'xxxx',
		en: 'Time from'
	},

	time_to: {
		he: 'xxxx',
		en: 'Time to'
	},

		address: {
		he: 'xxxx',
		en: ''
	},

	treatment_at_home: {
		he: 'xxxx',
		en: 'Treatment at home'
	},

	any_treatment: {
		he: 'xxxx',
		en: 'Any treatment'
	},

	any_time: {
		he: 'xxxx',
		en: 'Any Time'
	},

	address: {
		he: 'xxxx',
		en: 'Address'
	},

		submitted: {
		he: 'xxxx',
		en: 'Your quote request was submitted!'
	},

	expect_to_hear: {
		he: 'xxxx',
		en: 'Expect to hear from our professionals within 24 hours. '
	},

	contact_our: {
		he: 'xxxx',
		en: 'If you have any questions, feel free to contact our '
	},

	support: {
		he: 'xxxx',
		en: 'support'
	},

	no_sellers: {
		he: 'xxxx',
		en: 'Sorry, no sellers were found :('
	},

	try_searching: {
		he: 'xxxx',
		en: 'Try searching again with different criteria'
	},

#contact us
	contact_us: {
		he: 'xxxx',
		en: 'Contact Us'
	},

	phone: {
		he: 'xxxx',
		en: 'Phone'
	},

	enter: {
		he: 'xxxx',
		en: 'Please enter your phone'
	},

	text: {
		he: 'xxxx',
		en: 'Text'
	},

	tell_us: {
		he: 'xxxx',
		en: 'What would you like to tell us?'
	},

	performs_home_visits: {
		he: 'xxxx',
		en: '"Performs home visits"'
	},

	# : {
	# 	he: 'xxxx',
	# 	en: ''
	# },
# header


cosmeticall: {
		he: 'xxxx',
		en: 'Cosmeticall'
	},

	edit_profile: {
		he: 'xxxx',
		en: 'EDIT PROFILE'
	},

	sign_up_as_client: {
		he: 'xxxx',
		en: 'SIGN UP AS CLIENT'
	},

	sign_up_as_seller: {
		he: 'xxxx',
		en: 'SIGN UP AS SELLER'
	},

		log_in: {
		he: 'xxxx',
		en: 'Log in'
	},

	contact_us: {
		he: 'xxxx',
		en: 'CONTACT US'
	},

	admin: {
		he: 'xxxx',
		en: 'ADMIN'
	},

	log_out: {
		he: 'xxxx',
		en: 'LOG OUT'
	},

	#signup


 name: {
		he: 'xxxx',
		en: 'Name'
	},

 enter_name: {
		he: 'xxxx',
		en: 'Please enter your name'
	},

	phone: {
		he: 'xxxx',
		en: 'Phone'
	},

	profession: {
		he: 'xxxx',
		en: 'Profession'
	},

	treatments: {
		he: 'xxxx',
		en: 'Treatments'
	},

		area: {
		he: 'xxxx',
		en: 'Area'
	},

	description: {
		he: 'xxxx',
		en: 'Description'
	},

	sign_up: {
		he: 'xxxx',
		en: 'Sign Up'
	},
profile_picture: {
		he: 'xxxx',
		en: 'Profile Picture'
	},

	update_profile: {
		he: 'xxxx',
		en: 'Update Profile'
	},

	beautician: {
		he: 'xxxx',
		en: 'Beautician'
	},

	cosmetician: {
		he: 'xxxx',
		en: 'Cosmetician'
	},

		doctor: {
		he: 'xxxx',
		en: 'Doctor'
	},

	hairdresser: {
		he: 'xxxx',
		en: 'Hairdresser'
	},

	description_placeholder: {
		he: 'xxxx',
		en: 'Let us know more about you'
	},

		address_placeholder: {
		he: 'xxxx',
		en: 'Please enter your address'
	},

# search results

	thank_you_send_sms: {
		he: 'xxxx',
		en: "Thank you for contacting supplier! Here is supplier's phone"
	},

	enter_message: {
		he: 'xxxx',
		en: 'Please enter your message'
	},

	# admin

	set_language: {
		he: 'שנה שפה לעברית',
		en: 'Set language to English'
	},





	title: {
		he: 'תמצא קוסמטיקאית',
		en: 'Cosmeticall - Find The Best Cosmetician'
	},
	
	manicure: {
		he: 'xxxx',
		en: 'Manicure'
	},
	manicure_sub_option_1: {
		he: 'xxxx',
		en: 'mini-manicure'
	},
	manicure_sub_option_2: {
		he: 'xxxx',
		en: 'full manicure'
	},
	manicure_sub_option_3: {
		he: 'xxxx',
		en: 'polish'
	},
	manicure_sub_option_4: {
		he: 'xxxx',
		en: 'super full manicure'
	},
	pedicure: {
		he: 'xxxx',
		en: 'Pedicure'
	},
	pedicure_sub_option_1: {
		he: 'xxxx',
		en: 'mini-pedicure'
	},
	pedicure_sub_option_2: {
		he: 'xxxx',
		en: 'full pedicure'
	},
	pedicure_sub_option_3: {
		he: 'xxxx',
		en: 'polish'
	},
	pedicure_sub_option_4: {
		he: 'xxxx',
		en: 'super full pedicure'
	},
	hair_treatment: {
		he: 'xxxx',
		en: 'Hair Treatment'
	},
	hair_treatment_sub_option_1: {
		he: 'xxxx',
		en: 'haircut'
	},
	hair_treatment_sub_option_2: {
		he: 'xxxx',
		en: 'hair color'
	},
	hair_treatment_sub_option_3: {
		he: 'xxxx',
		en: 'blow dry'
	},
	hair_treatment_sub_option_4: {
		he: 'xxxx',
		en: 'super full hair treatment'
	},
}.hwia

def t(term, lang = nil)
	# In the t( ) function (which gets the language, if no language is supplied as a parameter,
	#  grab the default language from Redis ($redis.get( .. ) ). If Redis language is not 'en' or 'he', 
	#  use 'en


	lang ||= $redis.get("site_lang") || "en"
	# lang =  !lang ? $redis.get("site_lang") : "en"

	TEXTS[term][lang] rescue "missing definition for #{term}"
end


