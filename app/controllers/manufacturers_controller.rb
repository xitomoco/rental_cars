class ManufacturersController < ApplicationController

  def index
    @manufacturers = Manufacturer.all
  end

  def show
    set_manufacturer
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def create
    @manufacturer = Manufacturer.new(params_manufacturer)
    if @manufacturer.save
      redirect_to @manufacturer
    else
      @errors = filter_error
      render 'new'
    end
  end

  def edit
    set_manufacturer
  end
  
  def update
    set_manufacturer
    if @manufacturer.update(params_manufacturer)
      redirect_to @manufacturer
    else
      @errors = filter_error
      render 'edit'
    end
  end

  def destroy
    set_manufacturer
    if @manufacturer.destroy
      flash[:notice] = 'Fabricante deletado com sucesso'
      redirect_to manufacturers_path
    else
      flash[:error] = 'Algo deu errado ao deletar'
      redirect_to manufacturers_path
    end
  end

  private

  def params_manufacturer
    params.require(:manufacturer).permit(:name)
  end

  def filter_error
    @manufacturer.errors.messages.map{|attribure, message| message}.uniq
  end

  def set_manufacturer
    @manufacturer = Manufacturer.find(params[:id])
  end
end
