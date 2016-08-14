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
		he: 'בכל מקום',
		en: 'Anywhere'
	},

	found: {
		he: 'נמצאו',
		en: 'Found'
	},

	users: {
		he: 'תוצאות',
		en: 'users'
	},

	treatment_type: {
		he: 'סוג טיפול',
		en: 'Treatment Type'
	},

	treatment: {
		he: 'טיפול',
		en: 'Treatment'
	},

	
	area: {
		he: 'איזור',
		en: 'Area'
	},

	home_visits: {
		he: 'עושה טיפולי בית',
		en: 'Home visits'
	},

	tel_aviv: {
		he: 'ת"א',
		en: 'Tel Aviv'
	},

	haifa: {
		he: 'חיפה',
		en: 'Haifa'
	},

	ashdod: {
		he: 'אשדוד',
		en: 'Ashdod'
	},

	beer_sheva: {
		he: 'באר-שבע',
		en: 'Beer Sheva'
	},

#buttons
			search: {
		he: 'חיפוש',
		en: 'Search'
	},
# stuff

	sign_in_as_user: {
		he: 'אדמין - להיכנס בתור המשתמש הזה',
		en: 'Sign in as user'
	},

	found_users: {
		he: 'משתמשים שנמצאו',
		en: 'Found users'
	},

	send_sms: {
		he: 'שלח הודעה',
		en: 'Send sms'
	},

	send: {
		he: 'שלח',
		en: 'Send'
	},

	
	#get_quote page
	get_quote: {
		he: 'הצעת מחיר',
		en: 'Get Quote'
	},


	my_phone_number: {
		he: 'המספר שלי',
		en: 'My Phone Number'
	},

	month: {
		he: 'חודש',
		en: 'Month'
	},

	day: {
		he: 'יום',
		en: 'Day'
	},

	time_from: {
		he: 'בין השעה...',
		en: 'Time from'
	},

	time_to: {
		he: 'עד השעה...',
		en: 'Time to'
	},

		address: {
		he: 'כתובת',
		en: 'address'
	},

	treatment_at_home: {
		he: 'טיפול בבית?',
		en: 'Treatment at home'
	},

	any_treatment: {
		he: 'כל טיפול',
		en: 'Any treatment'
	},

	any_time: {
		he: 'כל שעה',
		en: 'Any Time'
	},

	address: {
		he: 'כתובת',
		en: 'Address'
	},

		submitted: {
		he: 'בקשה נשלחה!',
		en: 'Your quote request was submitted!'
	},

	expect_to_hear: {
		he: 'תצפה לשמוע מאיתנו תוך 24 שעות.',
		en: 'Expect to hear from our professionals within 24 hours. '
	},

	contact_our: {
		he: 'צור קשר',
		en: 'If you have any questions, feel free to contact our '
	},

	support: {
		he: 'תמיכה',
		en: 'support'
	},

	no_sellers: {
		he: 'לא נמצאו תוצאות',
		en: 'Sorry, no sellers were found :('
	},

	try_searching: {
		he: 'נסה/י לחפש עם תנאים אחרים.',
		en: 'Try searching again with different criteria'
	},

#contact us
	contact_us: {
		he: 'צור קשר',
		en: 'Contact Us'
	},

	phone: {
		he: 'טלפון',
		en: 'Phone'
	},

	enter: {
		he: 'נא להכניס מספר טלפון',
		en: 'Please enter your phone'
	},

	text: {
		he: 'הודעה',
		en: 'Text'
	},

	tell_us: {
		he: 'מה תרצה לספר לנו?',
		en: 'What would you like to tell us?'
	},

	performs_home_visits: {
		he: 'עושה ביקורי בית',
		en: '"Performs home visits"'
	},

	# : {
	# 	he: 'xxxx',
	# 	en: ''
	# },
# header


cosmeticall: {
		he: 'קוסמטיקול',
		en: 'Cosmeticall'
	},

	edit_profile: {
		he: 'לערוך פרופיל',
		en: 'EDIT PROFILE'
	},

	sign_up_as_client: {
		he: 'להירשם כלקוח',
		en: 'SIGN UP AS CLIENT'
	},

	sign_up_as_seller: {
		he: 'להירשם כמוכר',
		en: 'SIGN UP AS SELLER'
	},

		log_in: {
		he: 'לוגין',
		en: 'Log in'
	},

	contact_us: {
		he: 'צור קשר',
		en: 'CONTACT US'
	},

	admin: {
		he: 'אדמין',
		en: 'ADMIN'
	},

	log_out: {
		he: 'לצאת',
		en: 'LOG OUT'
	},

	#signup


 name: {
		he: 'שם',
		en: 'Name'
	},

 enter_name: {
		he: 'נא להכניס את השם שלך',
		en: 'Please enter your name'
	},

	phone: {
		he: 'טלפון',
		en: 'Phone'
	},

	profession: {
		he: 'מקצוע',
		en: 'Profession'
	},

	treatments: {
		he: 'טיפולים',
		en: 'Treatments'
	},

		area: {
		he: 'איזור',
		en: 'Area'
	},

	description: {
		he: 'תיאור',
		en: 'Description'
	},

	sign_up: {
		he: 'להירשם',
		en: 'Sign Up'
	},
profile_picture: {
		he: 'תמונת פרופיל',
		en: 'Profile Picture'
	},

	update_profile: {
		he: 'לעדכן פרופיל',
		en: 'Update Profile'
	},

	beautician: {
		he: 'מאפרת',
		en: 'Beautician'
	},

	cosmetician: {
		he: 'קוסמטיקאית',
		en: 'Cosmetician'
	},

		doctor: {
		he: 'רופא/ה',
		en: 'Doctor'
	},

	hairdresser: {
		he: 'מעצבת שיער',
		en: 'Hairdresser'
	},

	description_placeholder: {
		he: 'ספר/י לנו עוד עלייך',
		en: 'Let us know more about you'
	},

		address_placeholder: {
		he: 'אנא הכניסי/י את הכתובת שלך',
		en: 'Please enter your address'
	},

# search results

	thank_you_send_sms: {
		he: 'תודה על ההודעה! הנה המספר שלו/ה:',
		en: "Thank you for contacting supplier! Here is supplier's phone"
	},

	enter_message: {
		he: 'אנא הכניס/י את ההודעה שלך',
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
		he: 'מניקור',
		en: 'Manicure'
	},
	manicure_sub_option_1: {
		he: 'מיני-מניקור',
		en: 'mini-manicure'
	},
	manicure_sub_option_2: {
		he: 'מניקור מלא',
		en: 'full manicure'
	},
	manicure_sub_option_3: {
		he: 'פוליש',
		en: 'polish'
	},
	manicure_sub_option_4: {
		he: 'מניקור מלא פלוס',
		en: 'super full manicure'
	},
	pedicure: {
		he: 'פדיקור',
		en: 'Pedicure'
	},
	pedicure_sub_option_1: {
		he: 'מיני-פדיקור',
		en: 'mini-pedicure'
	},
	pedicure_sub_option_2: {
		he: 'פדיקור מלא',
		en: 'full pedicure'
	},
	pedicure_sub_option_3: {
		he: 'פוליש',
		en: 'polish'
	},
	pedicure_sub_option_4: {
		he: 'פדיקור מלא פלוס',
		en: 'super full pedicure'
	},
	hair_treatment: {
		he: 'טיפול שיער',
		en: 'Hair Treatment'
	},
	hair_treatment_sub_option_1: {
		he: 'תספורת',
		en: 'haircut'
	},
	hair_treatment_sub_option_2: {
		he: 'צביעת שיער',
		en: 'hair color'
	},
	hair_treatment_sub_option_3: {
		he: 'ייבוש שיער',
		en: 'blow dry'
	},
	hair_treatment_sub_option_4: {
		he: 'טיפול שיער מלא פלוס',
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


