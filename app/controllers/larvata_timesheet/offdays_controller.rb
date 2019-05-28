require_dependency "larvata_timesheet/application_controller"

module LarvataTimesheet
  class OffdaysController < ApplicationController
    def index
      date_id = params[:date_id] || Date.today.to_s
      render json: { data: CalendarView.call(date_id) }
    end

    def create
      offday = Offday.find_or_initialize_by(date_id: offday_params[:date_id])
      offday.is_off = offday_params[:is_off]

      if offday.save
        render json: { message: true }, status: 201
      else
        render json: { message: offday.errors.full_messages }, status: 400
      end
    end

    private

    def offday_params
      params.permit(:date_id, :is_off)
    end
  end
end
