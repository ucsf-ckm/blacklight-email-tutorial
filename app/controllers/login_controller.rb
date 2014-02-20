class LoginController < ApplicationController
  include Blacklight::Configurable

  def myaccess
    @user = User.find_by_email("abc@123.com")  #swap to request.headers['eppn'] for shib
    
    if @user.nil?
      @user = User.new(:email => 'abc@123.com', :password => 'password', :password_confirmation => 'password')
      @user.save
    end
    
    sign_in @user
    
    redirect_to '/'
  end
  
end
