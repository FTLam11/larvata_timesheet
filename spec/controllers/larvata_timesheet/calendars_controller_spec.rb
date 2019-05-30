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

    describe 'POST calendars#create' do
      context 'with new calendars' do
        context 'and valid params' do
          it 'batch creates calendars' do
            params = {
              calendars: [
                { name: 'First', default: false },
                { name: 'Second', default: true }
              ]
            }

            post calendars_path, params: params

            expect(response).to(have_http_status(201))
          end
        end

        context 'and mix of valid/invalid params' do
          it 'responds with errors for each calendar' do
            params = {
              calendars: [
                { name: 'First', default: false },
                { name: '', default: true }
              ]
            }

            post calendars_path, params: params
            formatted_errors = body_content["message"].all? { |o| o.keys == %w(id errors) }

            expect(formatted_errors).to(be(true))
            expect(response).to(have_http_status(400))
          end
        end
      end
    end

    describe 'DELETE calendars#destroy' do
      it 'destroys non-default calendars' do
        calendar = create(:calendar, default: false)

        delete calendar_path(calendar)

        expect { calendar.reload }.to(raise_error(ActiveRecord::RecordNotFound))
        expect(response).to(have_http_status(204))
      end

      it 'does not destroy default calendars and responds with an error' do
        calendar = create(:calendar, default: true)

        delete calendar_path(calendar)

        expect(response).to(have_http_status(400))
      end
    end
  end
end
