class StoreController < ApplicationController
  def index
    @products = Product.all.order(:title)
  end
end
