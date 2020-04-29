class CarModelsController < ApplicationController

    def index
        @car_models = CarModel.all
    end

    def show
        set_car_models
    end

    private

    def set_car_models
        @car_model = CarModel.find(params[:id])
    end
end