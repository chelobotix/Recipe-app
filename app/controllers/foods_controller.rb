class FoodsController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create destroy]
  before_action :set_food, only: %i[show edit update destroy]

  # GET /foods or /foods.json
  def index
    @foods = if current_user
               current_user.foods
             else
               Food.all
             end
  end

  # GET /foods/new
  def new
    @food = Food.new
    @recipe_id = params[:recipe_id]
  end

  # POST /foods or /foods.json
  def create
    @food = current_user.foods.build(food_params.except(:recipe_id))
    if @food.save
      redirect_to foods_path, notice: 'Food was successfully created.'
    else
      redirect_to new_food_path, notice: 'Food was not successfully created.'
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    @food.destroy

    respond_to do |format|
      format.html { redirect_to foods_url, notice: 'Food was successfully destroyed.' }
    end
  end

  # GET /shopping_list
  def shopping_list
    @user = current_user

    render :shopping_list
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_food
    @food = Food.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :recipe_id)
  end
end
