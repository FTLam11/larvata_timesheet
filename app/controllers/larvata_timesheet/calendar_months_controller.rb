require_dependency "larvata_timesheet/application_controller"

module LarvataTimesheet
  class CalendarMonthsController < ApplicationController
    before_action :set_calendar_month, only: [:show, :update]

    def create
      calendar_month = CalendarMonth.new(calendar_month_params)

      if calendar_month.save
        render json: { message: true, data: calendar_month }, status: 201
      else
        render json: { message: calendar_month.errors.full_messages }, status: 400
      end
    end

    def show
      render json: { data: @calendar_month }
    end

    def update
      if @calendar_month.update(calendar_month_params)
        render json: { message: true }
      else
        render json: { message: @calendar_month.errors.full_messages }, status: 400
      end
    end

    private

    def calendar_month_params
      params.permit(:date_id, :enabled)
    end

    def set_calendar_month
      @calendar_month = CalendarMonth.find_or_initialize_by(date_id: params[:date_id])
      @calendar_month.enabled = true unless @calendar_month.persisted?
    end
  end
end
