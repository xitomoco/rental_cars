class ManufacturersController < ApplicationController

  def index
    @manufacturers = Manufacturer.all
  end

  def show
    @manufacturer = Manufacturer.find(params[:id])
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def create
    @manufacturer = Manufacturer.new(params_manufacturer)
    if @manufacturer.save
      redirect_to manufacturer_url(@manufacturer)
    end
  end

  def params_manufacturer
    params.require(:manufacturer).permit(:name)
  end
end
