class RentalsController < ApplicationController

  def index
    @rentals = Rental.all
  end

  def show
    set_rental
  end

  def new
    @rental = Rental.new
    @customers = Customer.all
    @car_categories = CarCategory.all
  end

  def create
    @rental = Rental.new(params_rental)
    if @rental.save
      redirect_to @rental
    else
      @customers = Customer.all
      @car_categories = CarCategory.all
      render 'new'
    end
  end
  
  
  private

  def params_rental
    params.require(:rental).permit(:start_date, :end_date, :customer_id, :car_category_id)
  end

  def set_rental
    @rental = Rental.find(params[:id])
  end
end