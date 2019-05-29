require 'rails_helper'

module LarvataTimesheet
  RSpec.describe CalendarsController, type: :request do
    describe 'GET calendars#index' do
      it 'responds with all calendars' do
        calendar = create(:calendar)

        get calendars_path

        expect(response).to(have_http_status(200))
        expect(body_content["data"]).to(include(JSON.parse(calendar.to_json)))
      end
    end
  end
end
