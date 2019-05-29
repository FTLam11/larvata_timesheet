require_dependency "larvata_timesheet/application_controller"

module LarvataTimesheet
  class CalendarsController < ApplicationController
    def index
      render json: { data: Calendar.all }
    end
  end
end
