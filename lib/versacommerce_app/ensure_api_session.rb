# -*- encoding : utf-8 -*-
module VersacommerceApp::EnsureApiSession
  extend ActiveSupport::Concern
  
  included do
    rescue_from ActiveResource::UnauthorizedAccess, :with => :close_session
  end
  
  def ensure_current_api_session
    session[:versacommerce] = nil if params[:shop].present? && current_shop && current_shop.url != params[:shop]
    
    if session[:versacommerce]
      begin
        VersacommerceAPI::Base.activate_session(session[:versacommerce])
        yield
      ensure 
        VersacommerceAPI::Base.clear_session
      end
    else
      session[:return_to] = request.fullpath if request.get?
      redirect_to login_path(shop: params[:shop])
    end
  end
  
  def current_shop
    session[:versacommerce]
  end
  
  protected
  
  def close_session
    session[:versacommerce] = nil
    redirect_to login_path
  end
end
