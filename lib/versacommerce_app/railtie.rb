# -*- encoding : utf-8 -*-
require 'rails'

class VersacommerceApp::Railtie < ::Rails::Railtie

  config.before_configuration do
    config.versacommerce = VersacommerceApp.configuration
  end
  
  initializer "versacommerce_app.action_controller_integration" do
    ActionController::Base.send :include, VersacommerceApp::EnsureApiSession
    ActionController::Base.send :helper_method, :current_shop
  end
  
  initializer "versacommerce_app.setup_session" do
    VersacommerceApp.setup_session
  end
end
