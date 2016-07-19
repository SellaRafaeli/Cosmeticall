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

PROFESSIONS = ['Beautician','Cosmetician','Doctor', 'Hairdresser']
CITIES = ["Tel Aviv", "Haifa", "Ashdod", "Holon", "Rishon le Zion", "Beer Sheva"]

TREATMENTS = ["Manicure", "Pedicure", "Make up", "Facial Cleaning", "Haircut"]
SAMPLE_PROFILE_PICS = ["http://i.imgur.com/ZCe8trw.jpg", "https://s-media-cache-ak0.pinimg.com/736x/33/7d/7f/337d7fd79cd23bda4ee9831c03a5049f.jpg", "http://i.imgur.com/xCxNN15.jpg", "http://i.imgur.com/mpMFP.jpg", "http://i.imgur.com/ScE1bnm.jpg"]

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
      description: 'My desc',
      treatments: ['Manicure','Pedicure','Make up','Facial Cleaning'].sample(rand(3)+1),
      home_visits: ["true", nil].sample})
end


def reset_data
  $users.delete_many
  $user_messages.delete_many
  600.times { create_fake_user }
  user = $users.random
  $users.update_id(user['_id'], {token: '123'})
end

def set_seed_data
  reset_data
end
# fb app token: EAAOxuLF0mJkBAH8r1ykzjhq5xeZCQ6WEZAb7TtcWNQ2eZBW887Lf9AYW3a10WvIJLWsD3uiXT9TZBgZAPwi2adBxCBLr14hVHorjjedy3W6gEPM6Gg3ZCUBfcHLFo6tZCu4fflBYIHfofzqoQ67W2pZABd87GLUSJCeFIIkTgGLeOAZDZD
