class MissingFoodDecorator
  attr_reader :food

  def initialize(food, missing_quantity)
    @food = food
    @missing_quantity = missing_quantity
  end

  def name
    food.name
  end

  def quantity
    @missing_quantity
  end

  def price
    food.price
  end
end
