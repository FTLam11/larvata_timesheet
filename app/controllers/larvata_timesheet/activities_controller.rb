module LarvataTimesheet
  class ActivitiesController < ApplicationController
    before_action :set_activity, only: [:update, :destroy]

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

    def update
      # TODO updating rank via promote/demote or drag-n-drop?
      if @activity.update(activity_params)
        render json: { message: true }
      else
        render json: { message: @activity.errors.full_messages }, status: 400
      end
    end

    def destroy
      Activity.find_nodes(@activity.id).update_all(enabled: false)
    end

    private

    def activity_params
      params.permit(:category_id, :name, :enabled)
    end

    def set_activity
      @activity = Activity.unscoped.find(params[:id])
    end
  end
end
