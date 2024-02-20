class CarsController < ApplicationController
  skip_before_action :protect_pages, only: [:index, :show]
  before_action :authorize!, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @types = Type.order(name: :asc)
    @cars = FindCars.new.call(car_params_index)
  end

  def show
    id = params[:id]
    @car_id = id
    car
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      redirect_to cars_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    car
  end

  def update
    if car.update(car_params)
      redirect_to cars_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if car.destroy
      redirect_to cars_path, notice: t('.destroyed'), status: :see_other
    else
      redirect_to cars_path, notice: t('.error'), status: :unprocessable_entity
    end
  end

  private

  def car_params
    params.require(:car).permit(:marca, :modelo, :transmision, :anio, :capacidad, :preciodiario, :type_id, images: [])
  end
  def car_params_index
    params.permit(:type_id, :min_price, :max_price, :filter_price_min, :filter_price_max)
  end
  def car
    @car = Car.find(params[:id])
  end
end


