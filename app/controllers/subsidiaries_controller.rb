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
      @errors = filter_error
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
      @errors = filter_error
      render :edit
    end
  end

  private

  def params_subsidiary
    params.require(:subsidiary).permit(:name, :cnpj, :address)
  end

  def filter_error
    @subsidiary.errors.messages.map{|attribure, message| message}.uniq
  end
end