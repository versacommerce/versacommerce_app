# -*- encoding : utf-8 -*-
require 'versacommerce_api'

module VersacommerceApp

  def self.configuration
    @configuration ||= VersacommerceApp::Configuration.new
  end
  
  def self.setup_session
    VersacommerceAPI::Session.setup(:api_key => VersacommerceApp.configuration.api_key, :secret => VersacommerceApp.configuration.secret)
  end
end

require 'versacommerce_app/ensure_api_session'
require 'versacommerce_app/configuration'
require 'versacommerce_app/railtie'
require 'versacommerce_app/version'
