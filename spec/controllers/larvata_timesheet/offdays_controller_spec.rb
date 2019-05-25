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

          get offdays_path

          expect(response).to(have_http_status(200))
          expect(body_content["data"].size).to(be >= MIN_DATE_COUNT)
          expect(body_content["data"].size).to(be <= MAX_DATE_COUNT)
          expect(off_day?(today)).to(be(true))
        end
      end

      context 'with a date param' do
        it 'responds with calendar data for the selected date' do
          get offdays_path, params: { date_id: '2019-02-11' }

          expect(response).to(have_http_status(200))
          expect(body_content["data"].size).to(eq(35))
        end
      end
    end

    describe 'POST offdays#create' do
      context 'with valid date and offday inputs' do
        it 'creates an offday' do
          date = Date.today

          post offdays_path, params: { date_id: date.to_s, is_off: true }

          expect(response).to(have_http_status(201))
        end
      end

      context 'with invalid date input' do
        it 'does not create an offday and responds with an error' do
          offday_count = Offday.count

          post offdays_path, params: { date_id: 'AAA', is_off: true }

          expect(Offday.count).to(eq(offday_count))
          expect(response).to(have_http_status(400))
          expect(body_content["message"]).to(include("Date only allows YYYY-MM-DD format"))
        end
      end
    end

    describe 'PATCH offdays#update' do
      it 'updates an offday' do
        offday = create(:offday, is_off: false)

        patch offday_path(offday), params: { is_off: true }

        expect(offday.reload.is_off).to(be(true))
        expect(response).to(have_http_status(200))
      end
    end

    describe 'DELETE offdays#destroy' do
      it 'destroys an offday' do
        offday = create(:offday)

        delete offday_path(offday)

        expect { offday.reload }.to(raise_error(ActiveRecord::RecordNotFound))
        expect(response).to(have_http_status(204))
      end

      it 'returns an error when the activity does not exist' do
        offday = build(:offday, id: 9001)

        delete offday_path(offday)

        expect(response).to(have_http_status(401))
      end
    end
  end
end
