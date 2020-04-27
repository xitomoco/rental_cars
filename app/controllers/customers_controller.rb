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
      @errors = filter_error
      render 'new'
    end
  end

  private

  def params_customer
    params.require(:customer).permit(:name, :cpf, :email)
  end

  def filter_error
    @customer.errors.messages.map{|attribure, message| message}.uniq
  end
end
