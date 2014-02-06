require "#{Blacklight.root}/lib/blacklight/routes.rb"

# -*- encoding : utf-8 -*-
require 'deprecation'
module Blacklight
  class Routes
    extend Deprecation

    protected

    module RouteSets
    
      def saved_searches(_)
        add_routes do |options|
          delete "saved_searches/clear",       :to => "saved_searches#clear",   :as => "clear_saved_searches"
          get "saved_searches",       :to => "saved_searches#index",   :as => "saved_searches"
          put "saved_searches/save/:id",    :to => "saved_searches#save",    :as => "save_search"
          delete "saved_searches/forget/:id",  :to => "saved_searches#forget",  :as => "forget_search"
          post "saved_searches/forget/:id",  :to => "saved_searches#forget"
          get "saved_searches/email",       :to => "saved_searches#email",   :as => "email_saved_searches"
          post "saved_searches/email"
        end
      end
      
    end
    include RouteSets
  end
end