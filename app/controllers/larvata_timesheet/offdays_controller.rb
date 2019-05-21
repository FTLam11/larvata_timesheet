require_dependency "larvata_timesheet/application_controller"

module LarvataTimesheet
  class OffdaysController < ApplicationController
    def index
      date_id = params[:date] || Date.today.to_s
      render json: { data: CalendarView.call(date_id) }
    end
  end
end