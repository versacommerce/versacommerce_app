# -*- encoding : utf-8 -*-
require 'rails/generators'

class VersacommerceAppGenerator < Rails::Generators::Base
  argument :api_key, :type => :string, :required => false
  argument :secret, :type => :string, :required => false
  
  class_option :skip_routes, :type => :boolean, :default => false, :desc => 'pass true to skip route generation'
  
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
