require_dependency "larvata_timesheet/application_controller"

module LarvataTimesheet
  class CalendarsController < ApplicationController
    before_action :set_calendar, only: [:destroy]

    def index
      render json: { data: Calendar.all }
    end

    def create
      batch = calendar_params[:calendars].partition { |attrs| !attrs[:default] }.flatten.map do |attrs|
        if attrs[:id]
          Calendar.find(attrs[:id]).tap { |c| c.update(attrs) }
        else
          Calendar.create(attrs)
        end
      end

      if batch.all?(&:persisted?)
        render json: { calendars: batch }
      else
        render json: { message: batch.map { |o| { id: o.id, errors: o.errors.full_messages } } }, status: 400
      end
    end

    def destroy
      if @calendar.default
        render json: { message: "Can't delete a default calendar" }, status: 400
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
