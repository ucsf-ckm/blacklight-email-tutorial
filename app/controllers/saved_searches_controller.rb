require "#{Blacklight.root}/app/controllers/saved_searches_controller.rb"

# -*- encoding : utf-8 -*-
class SavedSearchesController < ApplicationController
  include Blacklight::Configurable

  # Email Action (this will render the appropriate view on GET requests and process the form and send the email on POST requests)

  def email
  
     @searches = current_user.searches

     if request.post? and validate_email_params
        
        # only send searches that were checked in the email form
        @searches = Array.new
        @comments = Hash.new

         current_user.searches.each do |s|
           if params[(s.id).to_s] == "1"
             @searches << s
             @comments[s.id] = params[("notes_" + (s.id).to_s)]
           end
         end
        
        email = SearchMailer.email_search(@searches, @comments, {:to => params[:to], :message => params[:message]}, url_options)
        email.deliver

        flash[:success] = I18n.t("blacklight.email.success")

        respond_to do |format|
           format.html { redirect_to catalog_path(params['id']) }
           format.js { render 'email_sent' }
        end and return
     end

     respond_to do |format|
        format.html
        format.js { render :layout => false }
     end
  end
  
  def validate_email_params
    case
    when params[:to].blank?
      flash[:error] = I18n.t('blacklight.email.errors.to.blank')
    when !params[:to].match(defined?(Devise) ? Devise.email_regexp : /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
      flash[:error] = I18n.t('blacklight.email.errors.to.invalid', :to => params[:to])
    end

    flash[:error].blank?
  end
  
end
