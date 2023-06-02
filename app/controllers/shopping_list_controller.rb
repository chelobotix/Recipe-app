class ShoppingListController < ApplicationController
  before_action :authenticate_user!
  def index
    user = current_user
    @missing_foods = []
    @total_price = 0

    user.recipes.includes(recipe_foods: :food).each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        available_food = recipe_food.food
        next unless available_food && available_food.quantity < recipe_food.quantity

        missing_quantity = recipe_food.quantity - available_food.quantity
        missing_food = MissingFoodDecorator.new(available_food, missing_quantity)
        @missing_foods << missing_food

        @total_price += missing_food.price * missing_food.quantity
      end
    end
  end
end
