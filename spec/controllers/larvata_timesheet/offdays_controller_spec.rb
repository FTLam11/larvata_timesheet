require 'rails_helper'

module LarvataTimesheet
  RSpec.describe(OffdaysController, type: :request) do
    describe 'GET offdays#index' do
      MIN_DATE_COUNT = 4 * 7
      MAX_DATE_COUNT = 6 * 7

      context 'with no date param' do
        it 'responds with the current calendar data' do
          today = Date.today.to_s
          create(:offday, date_id: today, is_off: true)

          get '/larvata_timesheet/offdays'

          expect(response.status).to(eq(200))
          expect(response.content_type).to(eq('application/json'))
          expect(body_content["data"].size).to(be >= MIN_DATE_COUNT)
          expect(body_content["data"].size).to(be <= MAX_DATE_COUNT)
          expect(off_day?(today)).to(be(true))
        end
      end

      context 'with a date param' do
        it 'responds with calendar data for the selected date' do
          get '/larvata_timesheet/offdays', params: { date: '2019-02-11' }

          expect(response.status).to(eq(200))
          expect(response.content_type).to(eq('application/json'))
          expect(body_content["data"].size).to(eq(35))
        end
      end
    end
  end
end
