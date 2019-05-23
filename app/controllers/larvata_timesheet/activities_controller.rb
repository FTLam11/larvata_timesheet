module LarvataTimesheet
  class ActivitiesController < ApplicationController
    def index
      render json: { data: Activity.to_tree }
    end
  end
end
