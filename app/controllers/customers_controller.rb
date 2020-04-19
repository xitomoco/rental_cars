class CustomersController < ApplicationController
	
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(params_customer)
    if @customer.save
      redirect_to @customer
    else
      flash_spaces
      render 'new'
    end
  end

  private

  def params_customer
    params.require(:customer).permit(:name, :cpf, :email)
  end

  def flash_spaces
    flash[:spaces] = 'Você deve informar todos os dados do cliente'
  end
end
