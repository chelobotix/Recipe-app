class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods

  validates :name, presence: true
  validates :preparation_time, numericality: { greater_than: 0 }
  validates :cooking_time, numericality: { greater_than: 0 }

  def recipe_ingredient_quantity(food_id)
    recipe_foods.where(food_id: food_id)[0].quantity
  end

end
