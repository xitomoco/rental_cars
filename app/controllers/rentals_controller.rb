class RentalsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create]

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

  def search
    @q = params[:q]
    @rentals = Rental.all
    @rental = Rental.find_by(code: @q.upcase)
    if @q.blank?
      flash.now[:alert] = 'Busca não pode ficar em branco'
      render 'index'
    elsif @rental.blank?
      flash.now[:alert] = "Nenhum código foi em contrado para: #{@q}"
      render 'index'
    else
      render 'show'
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