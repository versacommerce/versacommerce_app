class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

  private

  def extract_locale_from_accept_language_header
    browser_locale   = request.env['HTTP_ACCEPT_LANGUAGE'].try(:scan, /^[a-z]{2}/).try(:first).try(:to_sym)
    session[:locale] = browser_locale if I18n.available_locales.include? browser_locale
  end

  def set_locale
    extract_locale_from_accept_language_header if session[:locale].blank?
    session[:locale] = I18n.default_locale if session[:locale].blank?
    session[:locale] = params[:locale] if params[:locale]
    I18n.locale = session[:locale]
    Rails.application.routes.default_url_options[:locale]= I18n.locale
  end

  # prepare variable for the views
  def set_installed_shops
    @installed_shops = session[:installed_shops]
  end

end
