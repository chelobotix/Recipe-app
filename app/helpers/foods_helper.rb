module FoodsHelper
  def food_names
    Food.all.where(user_id: current_user.id).map { |food| "#{food.id} - #{food.name}" }
  end
end
