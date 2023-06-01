class ShoppingListController < ApplicationController
  before_action :authenticate_user!
  def index
    @food_items = current_user.recipes.map(&:foods).flatten

    @missing_food_items = current_user.foods - @food_items
    @total_price = @missing_food_items.sum(&:price)
  end
end
