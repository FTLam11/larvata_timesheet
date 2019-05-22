require_dependency "larvata_timesheet/application_controller"

module LarvataTimesheet
  class OffdaysController < ApplicationController
    def index
      date_id = params[:date] || Date.today.to_s
      render json: { data: CalendarView.call(date_id) }
    end

    def create
      offday = Offday.new(offday_params)

      if offday.save
        render json: { message: true }, status: 201
      else
        render json: { message: offday.errors.full_messages }, status: 400
      end
    end

    def update
      offday = Offday.find(params[:id])

      if offday.update(offday_params)
        render json: { message: true }
      else
        render json: { message: offday.errors.full_messages }, status: 400
      end
    end

    def destroy
      Offday.find(params[:id]).destroy
    end

    private

    def offday_params
      params.permit(:date_id, :is_off)
    end
  end
end
