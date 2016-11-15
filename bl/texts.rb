get '/texts' do 
	redirect '/'
end

# <%=t('')%>

# TREATMENTS = {
#   manicure: ['manicure_sub_option_1', 'manicure_sub_option_2', 'manicure_sub_option_3', 'manicure_sub_option_4'],
#   pedicure: ['pedicure_sub_option_1', 'pedicure_sub_option_2', 'pedicure_sub_option_3', 'pedicure_sub_option_4'],
#   hair_treatment: ['hair_treatment_sub_option_1', 'hair_treatment_sub_option_2', 'hair_treatment_sub_option_3', 'hair_treatment_sub_option_4']
# }

TREATMENTS = {"ציפורניים (ידיים)": ["מניקור", "מיני מניקור", "מריחת לק", "לק ג'ל ידיים", "הדבקת ציפורניים", "בניית ציפורניים", "מילוי בנייה", "עיסוי ידיים"],
 "טיפולי פנים":  ["טיפול פנים מלא", "טיפול יופי", "בוטוקס", "מילוי קמטים", "צביעת ריסים", "הדבקת ריסים", "הלחמת ריסים", "צביעת גבות"],
 "ציפורניים (רגליים)": ["פדיקור קוסמטי", "מיני פדיקור", "פדיקור רפואי", "לק ג'ל רגלים"],
 "הסרות שיער": ["שעווה רגלים", "שעווה חצי רגל", "שעווה ביקיני", "שעווה ברזילאי", "שעווה ידיים", "שעווה בית שחי", "שעווה שפם", "מריטת שם בחוט", "מריטת גבות בחוט", "עיצוב גבות", "שעווה פנים", "שעווה אזור אחר בגוף", "הסרת שיער בלייזר", "הסרת שיער אינפרא אדום"],
 "איפור": ["איפור לארוע", "איפור כלה", "איפור קבוע"],
 "עיצוב שיער": ["פן שיער קצר", "פן שיער ארוך", "צביעת שיער", "צביעת שורשים", "תספורת לאישה", "תספורת קצוות", "תספורת לגבר", "צמות", "בייביליס", "תספורת לילד/ה"]
}

#TREATMENTS_LIST = ["מניקור", "מיני מניקור", "מריחת לק", "לק ג'ל ידיים", "הדבקת ציפורניים", "בניית ציפורניים", "מילוי בנייה", "עיסוי ידיים", "טיפול פנים מלא", "טיפול יופי", "בוטוקס", "מילוי קמטים", "צביעת ריסים", "הדבקת ריסים", "הלחמת ריסים", "צביעת גבות", "פדיקור", "מיני פדיקור", "פדיקור רפואי", "לק ג'ל רגלים", "שעווה רגלים", "שעווה חצי רגל", "שעווה ביקיני", "שעווה ברזילאי", "שעווה ידיים", "שעווה בית שחי", "שעווה שפם", "מריטת שם בחוט", "מריטת גבות בחוט", "עיצוב גבות", "שעווה פנים", "שעווה אזור אחר בגוף", "הסרת שיער בלייזר", "הסרת שיער אינפרא אדום", "איפור לארוע", "איפור כלה", "פן שיער קצר", "פן שיער ארוך", "צביעת שיער", "צביעת שורשים", "תספורת לאישה", "תספורת קצוות", "תספורת לגבר", "צמות", "בייביליס", "תספורת לילד/ה"].compact


PROFESSIONS = ['beautician','cosmetician','doctor','pedicurician','manicurician','fingernails_builder','hairdresser']

TEXTS = {
	# search page

    search: {
    he: 'חיפוש',
    en: 'Search'
},

    results: {
    he: 'תוצאות',
    en: 'Results'
},
    supplier: {
    he: 'פרטים',
    en: 'Details'
},

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

	home_visits: {
		he: 'הטיפול הנדרש הוא לבית הלקוח',
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

	get_quote_users: {
		he: 'הצעת מחיר מהמשתמשים להלן',
		en: 'Get Quote'
	},

	get_quote_explain: {
		he: 'הכניסי את הפרטים של הטיפול שאת רוצה, וקבלי פניות עם הצעת מחיר ב-סמס.',
		en: 'Enter what you need and get a quote.'
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

	time_around: {
		he: 'זמן סביב',
		en: 'Time around'
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
		he: 'כל הטיפולים',
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
		he: 'אם יש לך שאלות, ',
		en: 'If you have any questions, feel free to contact our '
	},

	support: {
		he: 'צרו קשר',
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
		he: 'צרו קשר',
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

	search_header: {
		he: 'בחרי בשירות',
		en: 'Beauty Professionals Near You'
	},

	search_explain: {
		he: 'לחצי על כפתור החיפוש וגלי אילו קוסמטיקאיות, רופאי אסטטיקה, פדיקוריסטיות ועוד נמצאים ממש כאן',
		en: 'Find the best beauty professionals near you.'
	},

	my_messages: {
		he: 'ההודעות שלי',
		en: 'My messages'
	},

	from: {
		he: 'מ',
		en: 'From'
	},

	to: {
		he: 'ל',
		en: 'to'
	},

	you: {
		he: 'את/אתה',
		en: 'You'
	},

	you_are_logged_in_as: {
		he: 'xxxx',
		en: '"You are now logged in as '
	},

	message_sent: {
		he: 'הודעתך נשלחה!',
		en: 'Your message was sent!'
	},

	already_answered_quote: {
		he: 'xxxx',
		en: "You already answered this quote request"
	},

	will_get_back_to_you: {
		he: 'אנחנו נחזור אליך בהקדם',
		en: 'We will get back to you soon'
	},

	number_not_requested: {
		he: 'xxxx',
		en: "Your phone number was not requested by this user. Please talk to our "
	},

	user_exists: {
		he: 'משתמש עם מספר הטלפון הזה כבר קיים, אנא היכנס',
		en: 'משתמש עם מספר הטלפון הזה כבר קיים, אנא היכנס ' 
	},

	welcome: {
		he: 'ברוך הבא',
		en: 'Welcome!'
	},

	info_updated: {
		en: 'Your info was updated!',
		he: 'המידע שלך עודכן!'
	},

	welcome_back: {
		en: 'Welcome back!',
		he: 'ברוך שובך!'
	},

	message_with_link: {
		he: 'שלחנו הודעה למספר זה עם קישור להיכנס :)', #???
		en: "Message sent with a Magic Link to sign in :)"
	},

	no_user_found: {
		en: 'User with this phone not found',
		he: "לא נמצאו משתמשים עם הטלפון הזה"
	},


	hi: {
		he: 'היי',
		en: 'Hi!'
	},

	sent_you_message: {
		en: 'sent you following message',
		he: 'שלח לך הודעה הבאה:'
	},

	you_can_call: {
		he: ' אפשר להתקשר ',
		en: ' You can call'
	},

	to_schedule: {
		he: 'לתיאום פגישה!',
		en: 'to schedule a meeting!'
	},

	no_such_user: {
		he: 'משתמש לא קיים',
		en: "No such user"
	},

	# : {
	# 	he: 'xxxx',
	# 	en: ''
	# },

	# : {
	# 	he: 'xxxx',
	# 	en: ''
	# },

	# : {
	# 	he: 'xxxx',
	# 	en: ''
	# },

	# : {
	# 	he: 'xxxx',
	# 	en: ''
	# },

	# : {
	# 	he: 'xxxx',
	# 	en: ''
	# },

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
		he: 'רישום כלקוח/ה קבוע/ה',
		en: 'SIGN UP AS CLIENT'
	},

	sign_up_as_seller: {
		he: 'רישום כבעל/ת מקצוע',
		en: 'SIGN UP AS SELLER'
	},

		log_in: {
		he: 'התחבר/י',
		en: 'Log in'
	},

	contact_us: {
		he: 'צרו קשר',
		en: 'CONTACT US'
	},

	admin: {
		he: 'ממשק ניהול',
		en: 'ADMIN'
	},

	log_out: {
		he: 'לצאת',
		en: 'LOG OUT'
	},

	#signup

	just_name: {
		he: 'שם',
		en: 'Your name'
	},

 name: {
		he: 'חיפוש לפי שם',
		en: 'Name'
	},

	name_placeholder: {
		he: 'שם המטפלת',
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
		he: 'איזור בארץ',
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
		he: 'מאפר/ת',
		en: 'beautician'
	},

	pedicurician: {
		he: 'פדיקוריסט/ית',
		en: 'pedicurician'
		},

	manicurician: {
		he: 'מניקוסריסט/ית',
		en: 'manicurician'
	},

	fingernails_builder: {
		he: 'בונת ציפורניים',
		en: 'fingernails_builder'
	},

	cosmetician: {
		he: 'קוסמטיקאי/ת',
		en: 'Cosmetician'
	},

		doctor: {
		he: 'רופא/ה',
		en: 'doctor'
	},

	hairdresser: {
		he: 'מעצב/ת שיער',
		en: 'hairdresser'
	},

	description_placeholder: {
		he: 'למשל איזה עוד טיפולים הינך יודעת לבצע, דברים נוספים שחשוב ללקוח לדעת אודותיך?',
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

CITIES = ["אילת וערבה", "אריאל וישובי יהודה", "אשדוד - אשקלון והסביבה", "באר שבע והסביבה", "בית שמש והסביבה", "בני ברק - גבעת שמואל", "בקעת אונו", "בקעת הירדן וצפון ים המלח", "גדרה - יבנה והסביבה", "גוש עציון", "גליל עליון", "גליל תחתון", "דרום ים המלח", "הגולן", "הוד השרון והסביבה", "הכנרת והסביבה", "הנגב המערבי", "הרי יהודה - מבשרת והסביבה", "זכרון וחוף הכרמל", "חדרה והסביבה", "חולון - בת ים", "חיפה והסביבה", "יהודה שומרון ובקעת הירדן", "יקנעם טבעון והסביבה", "ירושלים", "ישובי דרום ההר", "ישובי הנגב", "ישובי שומרון", "כרמיאל והסביבה", "מודיעין והסביבה", "מעלה אדומים והסביבה", "נס ציונה - רחובות", "נצרת - שפרעם והסביבה", "נתניה והסביבה", "עכו - נהריה והסביבה", "עמק איילון", "עמק בית שאן", "עפולה והעמקים", "פתח תקווה והסביבה", "קיסריה והסביבה", "קריות והסביבה", "קרית גת והסביבה", "ראש העין והסביבה", "ראש פינה החולה", "ראשון לציון והסביבה", "רמלה - לוד", "רמת גן - גבעתיים", "רמת השרון - הרצליה", "רמת מנשה", "רעננה - כפר סבא", "שוהם והסביבה", "תל אביב - דרום", "תל אביב - מזרח", "תל אביב - מרכז", "תל אביב - צפון"].sort

HOSPITALS = ["איכילוב", "בילינסון", "תל השומר", "אסף הרופא", "רמב\"ם", "ברזילי", "לניאדו", "הלל יפה", "סורוקה", "יוספטל", "זיו", "פוריה", "העמק", "הדסה הר הצופים", "הדסה עין כרם", "שערי צדק", "מאיר", "וולפסון", "קפלן", "כרמל"].sort

HOSPITALS_FORMATTED = HOSPITALS.map { |hospital| "בית חולים "+hospital}

CITIES = CITIES.sort

CITIES += HOSPITALS_FORMATTED

CITIES.each { |city| TEXTS[city] = {he: city, en: city} }

TREATMENTS_TEXTS = TREATMENTS.flatten.flatten
TREATMENTS_TEXTS.each { |treatment| TEXTS[treatment] = {he: treatment, en: treatment} }

def t(term, lang = nil)
	# In the t( ) function (which gets the language, if no language is supplied as a parameter,
	#  grab the default language from Redis ($redis.get( .. ) ). If Redis language is not 'en' or 'he', 
	#  use 'he'

	lang = "he"

	z = TEXTS[term][lang] rescue 'e'
	if !z
		bp
		x=1
	end

	TEXTS[term][lang] rescue "missing definition for #{term}"
end

get '/refresh/bl/texts' do 
	'refresh this page'
end