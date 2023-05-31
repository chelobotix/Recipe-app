class RecipesController < ApplicationController
  before_action :set_recipe,
                only: %i[show destroy new_ingredient add_ingredient edit_ingredient update_ingredient
                         destroy_ingredient]

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.all
    puts @recipes
  end

  # GET /recipes/1 or /recipes/1.json
  def show; end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_path(id: @recipe), notice: 'Recipe was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # Select a new ingredient for a recipe
  # GET /recipes/1/new_ingredient
  def new_ingredient
    @recipe_food = RecipeFood.new

    render :new_ingredient
  end

  # POST /recipes/1/new_ingredient
  def add_ingredient
    @food = RecipeFood.new(ingredient_params)

    respond_to do |format|
      if @food.save
        format.html { redirect_to recipe_path(id: @recipe), notice: 'Ingredient was successfully added.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # GET /recipes/1/recipe_edit_ingredient
  def edit_ingredient
    @recipe_food = RecipeFood.new
  end

  # PUT /recipes/1/update_ingredient
  def update_ingredient
    if @recipe.recipe_foods.update(ingredient_params_update)
      redirect_to recipe_path(id: @recipe), notice: 'Ingredient was successfully updated.'
    else
      format.html { render :new, status: :unprocessable_entity }
    end
  end

  # DELETE /recipes/1/delete_ingredient
  def destroy_ingredient
    if @recipe.recipe_foods[params[:index].to_i].destroy
      redirect_to recipe_path(id: @recipe), notice: 'Ingredient was successfully deleted.'
    else
      format.html { render :new, status: :unprocessable_entity }
    end
  end

  # DELETE /recipes/1
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_path, notice: 'Recipe was successfully deleted.' }
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public).merge(
      user_id: current_user.id
    )
  end

  def ingredient_params
    food_id = params[:recipe_food][:food_select].to_s.split('-').first.rstrip.to_i
    params[:id]
    params.require(:recipe_food).permit(:quantity).merge(food_id:).merge(recipe_id: params[:id])
  end

  def ingredient_params_update
    params.require(:recipe_food).permit(:quantity, :food_id).merge(recipe_id: params[:id])
  end
end
