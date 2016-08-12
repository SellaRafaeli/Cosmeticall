puts "starting app..."

require 'bundler'

require 'active_support'
require 'active_support/core_ext'

require 'sinatra/reloader' #dev-only
# require 'sinatra/activerecord'

puts "requiring gems..."

Bundler.require

Dotenv.load

require './setup'
require './my_lib'

require_all './db'
require_all './admin'
require_all './bl'
require_all './comm'
require_all './logging'
require_all './mw'

include Helpers

$app_name   = 'Cosmeticall'
SAMPLE_PROFILE_PICS = ["https://c2.staticflickr.com/4/3646/3370468834_4ded68f9e7_z.jpg?zz=1", "https://upload.wikimedia.org/wikipedia/commons/3/3e/Antje_Tillmann_Portrait.jpg", "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcT_MD807yGqGdKuK-bvaSDNQlmF4aTQj_8I0hQdqg53YvLmf97G", "http://i.imgur.com/ScE1bnm.jpg"]


get '/ping' do
  {msg: "pong from #{$app_name}", val: 123}
end

get "/testing_erb" do 
   erb :"other/testing_erb", layout:nil
end


def create_fake_user
  $users.add({name: Faker::Name.name,
    fake: true,
    phone: "972054"+(rand(999999)+100000).to_s,
    profession: PROFESSIONS.sample,
      pic_url: SAMPLE_PROFILE_PICS.sample,
      address: Faker::Address.street_address,
      city: ['Tel Aviv','Haifa','Ashdod'].sample,
      description: "I'm an awesome professional",
      treatments: TREATMENTS.sample(rand(3)+1),
      home_visits: ["true", nil].sample})
end


def reset_data
  $users.delete_many
  $contact_supplier.delete_many
  600.times { create_fake_user }
  user = $users.random
  $users.update_id(user['_id'], {token: '123'})
end

def set_seed_data
  reset_data
end
# fb app token: EAAOxuLF0mJkBAH8r1ykzjhq5xeZCQ6WEZAb7TtcWNQ2eZBW887Lf9AYW3a10WvIJLWsD3uiXT9TZBgZAPwi2adBxCBLr14hVHorjjedy3W6gEPM6Gg3ZCUBfcHLFo6tZCu4fflBYIHfofzqoQ67W2pZABd87GLUSJCeFIIkTgGLeOAZDZD
