require_dependency "larvata_timesheet/application_controller"

module LarvataTimesheet
  class CalendarsController < ApplicationController
    before_action :set_calendar, only: [:destroy]

    def index
      render json: { data: Calendar.all }
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
  end
end
