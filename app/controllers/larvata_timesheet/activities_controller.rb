module LarvataTimesheet
  class ActivitiesController < ApplicationController
    def index
      render json: { data: Activity.to_tree }
    end

    def create
      activity = Activity.new(activity_params)

      if activity.save
        render json: { message: true }, status: 201
      else
        render json: { message: activity.errors.full_messages }, status: 400
      end
    end

    private

    def activity_params
      params.permit(:category_id, :name, :enabled)
    end
  end
end
