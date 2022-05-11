# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  around_action :ensure_current_api_session

  def index
    # get 10 products
    @products = VersacommerceAPI::Product.find(:all, :params => {:limit => 10})

    # get latest 5 orders
    @orders   = VersacommerceAPI::Order.find(:all, :params => {:limit => 5, :order => "created_at DESC" })
  end

end
