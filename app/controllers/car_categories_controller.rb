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
      flash_spaces
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

  def flash_spaces
    flash[:spaces] = 'Você deve informar todos os dados da categoria'
  end
end
