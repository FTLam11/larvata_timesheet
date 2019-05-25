require 'rails_helper'

module LarvataTimesheet
  RSpec.describe(CalendarMonthsController, type: :request) do
    describe 'GET calendar_months#show' do
      context 'with persisted calendar months' do
        it 'responds with the calendar month data' do
          calendar_month = create(:calendar_month, date_id: '2019-05')

          get calendar_month_path(calendar_month)

          expect(response).to(have_http_status(200))
          expect(body_content['data']).to(include(JSON.parse(calendar_month.to_json)))
          expect(body_content['data']['persisted']).to(be(true))
        end
      end

      context 'with unpersisted calendar months' do
        it 'responds with the calendar month data' do
          calendar_month = build(:calendar_month, date_id: '2019-05', enabled: true)

          get calendar_month_path(calendar_month)

          expect(response).to(have_http_status(200))
          expect(body_content['data']).to(include(JSON.parse(calendar_month.to_json)))
          expect(body_content['data']['persisted']).to(be(false))
        end
      end
    end

    describe 'POST calendar_months#create' do
      context 'with valid params' do
        it 'creates a calendar month' do
          calendar_month = build(:calendar_month, date_id: '2019-05', enabled: true)

          post calendar_months_path, params: { date_id: '2019-05', enabled: true }

          expect(body_content['data'].keys).to(include(*JSON.parse(calendar_month.to_json).keys))
          expect(response).to(have_http_status(201))
        end
      end

      context 'with invalid params' do
        it 'does not create a calendar month and responds with an error' do
          calendar_month_count = CalendarMonth.count

          post calendar_months_path, params: { date_id: '2019-05', enabled: nil }

          expect(CalendarMonth.count).to(eq(calendar_month_count))
          expect(response).to(have_http_status(400))
          expect(body_content['message']).to(include('Enabled only allows a valid boolean value'))
        end
      end
    end

    describe 'PATCH calendar_months#update' do
      context 'with valid params for an existing calendar month' do
        it 'updates a calendar month' do
          calendar_month = create(:calendar_month)

          patch calendar_month_path(calendar_month), params: { enabled: true }

          expect(calendar_month.reload.enabled).to(be(true))
          expect(response).to(have_http_status(200))
        end
      end
    end
  end
end
