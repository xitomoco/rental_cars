class CarCategoriesController < ApplicationController

  def index
    @carcategories = CarCategory.all
  end

  def new
    @carcategory = CarCategory.new
  end

  def create
    @carcategory = CarCategory.new(params_car_category)
    if @carcategory.save
      redirect_to @carcategory
    else
      @errors = filter_error
      render :new
    end
  end

  def show
    @carcategory = CarCategory.find(params[:id])
  end

  private

  def params_car_category
    params.require(:car_category).permit(:name, :daily_rate, :car_insurance, :third_party_insurance)
  end

  def filter_error
    @carcategory.errors.messages.map{|attribure, message| message}.uniq
  end
end
