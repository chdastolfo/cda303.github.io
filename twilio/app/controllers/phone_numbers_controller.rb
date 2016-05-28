class PhoneNumbersController < ApplicationController

skip_before_action :verify_authenticity_token

	def new
		@phone_number = PhoneNumber.new
	end

	def create
	  @phone_number = PhoneNumber.find_or_create_by(phone_number: params[:phone_number][:phone_number])
	  @phone_number.generate_pin
	  @phone_number.send_pin
	  #respond_to do |format|
	   # format.html {render 'new'}
	    #format.js {render app/views/phone_numbers/create.js.erb}
	  #end
	  redirect_to :back
	end
	
	def verify
 	@phone_number = PhoneNumber.find_by(phone_number: params[:hidden_phone_number])
  	@phone_number.verify(params[:pin])
  	#respond_to do |format|
  	#format.html { render 'new' }
  	#format.js {render app/views/phone_numbers/verify.js.erb}
  		#end
	end
end
