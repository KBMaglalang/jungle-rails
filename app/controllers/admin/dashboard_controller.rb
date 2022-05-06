class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]

  before_filter :authorize

  def show
    @products_count = Product.count
    @categories_count = Category.count
  end
end
