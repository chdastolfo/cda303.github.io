class PhoneNumber < ActiveRecord::Base
	
	@TWILIO_ACCOUNT_SID="AC3496581bfa611e1735fc72b4a0b4216c"
	@TWILIO_AUTH_TOKEN="e214ab2c6cbfdc902dd6298117aa012e" 

	def generate_pin
  self.pin = rand(0000..9999).to_s.rjust(4, "0")
  save
	end

	def twilio_client
  	Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
	end

	def send_pin
  	twilio_client.messages.create(
    to: phone_number,
    from: ENV['TWILIO_PHONE_NUMBER'],
    body: "What's up, dweebus? Your prize is a text message from me!"
  )
end

def verify(entered_pin)
  update(verified: true) if self.pin == entered_pin
end
end

#Your PIN is #{pin}