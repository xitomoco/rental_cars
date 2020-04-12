class CarCategoriesController < ApplicationController

    def index
        @carcategories = CarCategory.all
    end
end
