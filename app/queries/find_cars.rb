class FindCars

  attr_reader :cars

  def initialize(cars = initial_scope)
    @cars = cars
  end

  def call(params = {})
    scoped = cars
    scoped = filter_by_type(scoped, params[:type_id])
    scoped = filter_by_min_price(scoped, params[:min_price])
    scoped = filter_by_max_price(scoped, params[:max_price])
    scoped = order_by_minimum_price(scoped, params[:filter_price_min])
    scoped = order_by_maximum_price(scoped, params[:filter_price_max])
  end

  private

  def initial_scope
    Car.with_attached_images
  end

  def filter_by_type(scoped, type_id)
    return scoped unless type_id.present?
    scoped.where(type_id: type_id)
  end

  def filter_by_min_price(scoped, min_price)
    return scoped unless min_price.present?
    scoped.where('preciodiario >= ?', min_price)
  end

  def filter_by_max_price(scoped, max_price)
    return scoped unless max_price.present?
    scoped.where('preciodiario <= ?', max_price)
  end

  def order_by_minimum_price(scoped, filter_price_min)
    return scoped unless filter_price_min.present?
    scoped.order(preciodiario: :asc)
  end

  def order_by_maximum_price(scoped, filter_price_max)
    return scoped unless filter_price_max.present?
    scoped.order(preciodiario: :desc)
  end
end