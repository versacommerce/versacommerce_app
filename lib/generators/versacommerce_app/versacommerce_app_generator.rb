# -*- encoding : utf-8 -*-
require 'rails/generators'

class VersacommerceAppGenerator < Rails::Generators::Base
  argument :api_key, :type => :string, :required => false
  argument :secret, :type => :string, :required => false

  class_option :skip_routes, :type => :boolean, :default => false, :desc => 'pass true to skip route generation'

  def create_initializer_file
    if Gem::Requirement.new('>= 4.1').satisfied_by? Gem::Version.new(::Rails::VERSION::STRING)
      create_file "config/initializers/cookies_serializer.rb", <<-DATA
# Be sure to restart your server when you modify this file.

# Specify a serializer for the signed and encrypted cookie jars.
# Valid options are :json, :marshal, and :hybrid.
Rails.application.config.action_dispatch.cookies_serializer = :marshal
DATA
    end
  end

  def self.source_root
    File.join(File.dirname(__FILE__), 'templates')
  end

  def copy_files
    directory 'app'
    directory 'public'
    directory 'config'
  end

  def remove_static_index
    remove_file 'public/index.html'
  end

  def add_config_variables
    return if api_key.blank? || secret.blank?

    append_file 'config/versacommerce_api.yml', <<-DATA
development:
  api_key: #{api_key}
  secret: #{secret}

test:
  api_key: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  secret: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

production:
  api_key: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  secret: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    DATA
  end

  def add_routes
    unless options[:skip_routes]
      route_without_newline "root :to => 'home#index'"
      route "end"
      route_without_newline "  delete '/logout' => :destroy"
      route_without_newline "  post '/login' => :create"
      route_without_newline "  get '/login' => :new"
      route_without_newline "  get '/finalize' => :finalize"
      route_without_newline "controller :sessions do"
    end
  end

  def add_config_locale
    inject_into_file 'config/application.rb', <<-DATA, :after => "class Application < Rails::Application\n"
    
    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"
    config.time_zone = 'Berlin'
    
    # Allow all origins to include this app via <frame> or <iframe>.
    config.action_dispatch.default_headers = { 'X-Frame-Options' => 'ALLOWALL' }
    DATA
  end

  def show_readme
    `bundle install`
    readme '../README'
  end

  private

  def route_without_newline(routing_code)
    sentinel = /\.routes\.draw do(?:\s*\|map\|)?\s*$/
    inject_into_file 'config/routes.rb', "\n  #{routing_code}", { after: sentinel, verbose: false }
  end
end
