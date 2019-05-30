require_dependency "larvata_timesheet/application_controller"

module LarvataTimesheet
  class CalendarsController < ApplicationController
    before_action :set_calendar, only: [:destroy]

    def index
      render json: { data: Calendar.all }
    end

    def create
      batch = calendar_params[:calendars].map { |attrs| Calendar.create(attrs) }

      if batch.all?(&:persisted?)
        render json: {}, status: 201
      else
        render json: { message: batch.map { |o| { id: o.id, errors: o.errors.full_messages } } }, status: 400
      end
    end

    def destroy
      if @calendar.default
        render json: { message: @calendar.errors.full_messages }, status: 400
      else
        @calendar.destroy
      end
    end

    private

    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    def calendar_params
      params.permit(calendars: [:id, :name, :default])
    end
  end
end
