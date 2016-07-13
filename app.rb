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

get '/ping' do
  {msg: "pong from #{$app_name}", val: 123}
end

def create_fake_user
  $users.add({name: Faker::Name.name,
    phone: rand(10000).to_s,
    profession: ['Beautician','Cosmetician','Doctor'].sample,
      address: 'Some address',
      city: ['Tel Aviv','Haifa','Ashdod'].sample,
      description: 'My desc',
      treatments: ['Manicure','Pedicure','Make up','Facial Cleaning'].sample(rand(3)),
      home_visits: ["true", nil].sample})
end

def reset_data
  $users.delete_many
  $user_messages.delete_many
  60.times { create_fake_user }
  user = $users.random
  $users.update_id(user['_id'], {token: '123'})
end
# fb app token: EAAOxuLF0mJkBAH8r1ykzjhq5xeZCQ6WEZAb7TtcWNQ2eZBW887Lf9AYW3a10WvIJLWsD3uiXT9TZBgZAPwi2adBxCBLr14hVHorjjedy3W6gEPM6Gg3ZCUBfcHLFo6tZCu4fflBYIHfofzqoQ67W2pZABd87GLUSJCeFIIkTgGLeOAZDZD
