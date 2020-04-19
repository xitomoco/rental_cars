class SubsidiariesController < ApplicationController

	def index
		@subsidiaries = Subsidiary.all
	end

	def show
		@subsidiary = Subsidiary.find(params[:id])
	end

  def new
    @subsidiary = Subsidiary.new
  end

  def create
    @subsidiary = Subsidiary.create(params_subsidiary)
    if @subsidiary.save
      redirect_to @subsidiary
    else
      flash_spaces
      render :new
    end
  end

  def edit
    @subsidiary = Subsidiary.find(params[:id])
  end

  def update
    @subsidiary = Subsidiary.find(params[:id])
    if @subsidiary.update(params_subsidiary)
      redirect_to @subsidiary
    else
      flash_spaces
      render :edit
    end
  end

  private

  def params_subsidiary
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end

  def flash_spaces
    flash[:spaces] = 'Você deve informar todos os dados da filial'
  end
end