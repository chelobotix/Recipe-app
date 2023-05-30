class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

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

  # GET /recipes/1/edit
  def edit; end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to user_recipe_path(id: @recipe), notice: "Recipe was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to user_recipes_path, notice: "Recipe was successfully destroyed." }
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public).merge(
                                                                                                     user_id: current_user.id)
    end
end
