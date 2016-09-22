$sms_messages = $sms = $mongo.collection('sms_messages')

require 'twilio-ruby' 
 
 get '/sms_messages/all' do
	sms_messages = $sms_messages.all
	{sms_messages:sms_messages}
end

# put your own credentials here 
account_sid = 'ACfbbb449751b5c36f48fb0aa1f2065774' 

auth_token = ENV['TWILIO_AUTH_TOKEN']
 
# set up a client to talk to the Twilio REST API 
TWILIO_CLIENT ||= Twilio::REST::Client.new account_sid, auth_token 


def send_sms(to, body = nil, type, sender_phone)
	sms = $sms_messages.add({sender_phone:sender_phone,
                                       description: body, 
                                       receiver_phone: to,
                                       type:type})

  body ||= "test msg"
  #return if !$prod
  to   = "972"+to
  data = {from: '+972526288418', to: "+#{to}", body: body }
  TWILIO_CLIENT.account.messages.create(data)
rescue => e 
  log_e(e)
  false
end
