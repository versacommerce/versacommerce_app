# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController

  def new
    authenticate if params[:shop].present?
  end

  def create
    authenticate
  end
    
  def destroy
    session[:versacommerce] = nil
    flash[:success]         = t('sessions.controller.destroy')
    redirect_to :action => 'new'
  end
  
  def finalize
    current_session = VersacommerceAPI::Session.new(params[:shop], params[:t], params)
    if current_session.valid?
      #
      # IF YOU WANT TO SAVE THE TOKEN FOR LATER USE,
      #
      # 1) CREATE A MODEL
      # $ rails generate model user shop:string token:string
      # $ rake db:create && rake db:migrate
      #
      # 2) SAVE THE TOKEN RIGHT HERE
      # User.where(shop: params[:shop]).first_or_create do |user|
      #   user.token = params[:t]
      # end
      #
      # 3) USE THE TOKEN TO CONNECT TO THIS SHOP WITHOUT USER INTERACTION
      # https://github.com/versacommerce/versacommerce_api (see sample code)
      #
      session[:versacommerce] = current_session
      flash[:success]         = t('sessions.controller.finalize_ok')
      redirect_to return_address
    else
      flash[:warning] = t('sessions.controller.finalize_error')
      redirect_to :action => 'index'
    end
  end
  
  protected
  
  def authenticate
    if shop_name = sanitize_shop_param(params)
      redirect_to VersacommerceAPI::Session.new(shop_name).create_permission_url
    else
      redirect_to return_address
    end
  end
  
  def return_address
    session[:return_to] || root_url
  end
  
  def sanitize_shop_param(params)
    return unless params[:shop].present?
    name = params[:shop].to_s.strip
    name += '.versacommerce.de' if !name.include?("versacommerce.de") && !name.include?(".")
    name.sub('https://', '').sub('http://', '')
    u = URI("http://#{name}")
    u.host.ends_with?("versacommerce.de") ? u.host : nil
  end

end
