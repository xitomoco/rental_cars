class CarModelsController < ApplicationController

  def index
    @car_models = CarModel.all
  end

  def show
    set_car_models
  end

  def new
    @car_model = CarModel.new
    @manufacturers = Manufacturer.all
    @car_categories = CarCategory.all
  end

  def create
    @car_model = CarModel.new(params_car_model)
    if @car_model.save
      redirect_to @car_model
    else
      filter_error
      render 'new'
    end
  end

  private

  def params_car_model
    params.require(:car_model).permit(:name, :motorization, :year, :fuel_type, :manufacturer_id, 
                                      :car_category_id)
  end

  def set_car_models
    @car_model = CarModel.find(params[:id])
  end

  def filter_error
    @car_model.errors.messages.map{|attribure, message| message}.uniq
  end
end