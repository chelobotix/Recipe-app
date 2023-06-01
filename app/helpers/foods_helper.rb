module FoodsHelper
  def food_names
    Food.all.map { |food| "#{food.id} - #{food.name}" }
  end
end
