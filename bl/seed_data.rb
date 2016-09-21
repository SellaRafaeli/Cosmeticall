SAMPLE_PROFILE_PICS = ["https://c2.staticflickr.com/4/3646/3370468834_4ded68f9e7_z.jpg?zz=1", "https://upload.wikimedia.org/wikipedia/commons/3/3e/Antje_Tillmann_Portrait.jpg", "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcT_MD807yGqGdKuK-bvaSDNQlmF4aTQj_8I0hQdqg53YvLmf97G", "http://i.imgur.com/ScE1bnm.jpg"]



def fake_name
  ['יעל', 'שירה', 'רונית', 'דנה', 'רחל', 'אופירה', 'בת-אל', 'חני', 'איילת', 'איילה', 'נעמי', 'נעה', 'קארין', 'עידית', 'עירית', 'עינת', 'ליטל', 'שרון', 'שרונה', 'נורית', 'ליאת', 'שחר', 'רויטל', 'יעל', 'אינה', 'שני', 'שמחה'].sample + ' ' + 
  ['כהן', 'לוי', 'בוזגלו', 'בר-אור', 'גל-אור', 'גנור', 'רון', 'אחיטוב', 'אהרונסון', 'אלימלך', 'גרשון', 'מלכיאור', 'בר-אל', 'גלנט', 'כחלון', 'לפיד', 'פדצור', 'סימן-טוב', 'בוקנסבאום', 'דומב', 'אבקסיס', 'ברדה', 'שחר', 'בניון', 'בן-סימון', 'גבע', 'אהרוני', 'לוינסון', 'שגב', 'מגל'].sample
end

def fake_address
  ["אבא קובנר", "אבודהרם", "אבולעפיה", "אביגור שאול", "אבן גבירול", "אבן רושד", "אברבנאל", "אברבנל", "אברהם אבן שושן", "אבשלום חביב", "אגדתי", "אגריפס", "אדם הכהן", "אדוארד ברנשטיין", "אדירים", "אהבת ציון", "אהרון בקר", "אהרון מויאל", "אהרונוביץ", "אהרונסון"].sample + ' ' + rand(200).to_s
end

def create_fake_user(city, treatment = nil)
  $users.add({name: fake_name,
    fake: true,
    phone: "054"+(rand(999999)+100000).to_s,
    profession: PROFESSIONS.sample,
      pic_url: SAMPLE_PROFILE_PICS.sample,
      address: fake_address,
      city: city,
      description: "I'm an awesome professional",
      treatments: treatment || TREATMENTS.values.flatten.sample(rand(3)+1),
      home_visits: ["true", nil].sample})
end

def add_fake_users
  $contact_supplier.delete_many
  CITIES.each { |city,idx| 4.times { create_fake_user(city) } }
  TREATMENTS.values.flatten.each { |treatment| 4.times { create_fake_user(CITIES.sample, treatment) } }
  #create_israeli_user
  user = $users.random
  $users.update_id(user['_id'], {token: '1234'})
end

def seed_data
  add_fake_users
end

def remove_fake_users
  $users.delete_many(fake: true)
end