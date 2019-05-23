require 'rails_helper'

module LarvataTimesheet
  RSpec.describe(ActivitiesController, type: :request) do
    describe 'GET activities#index' do
      it 'responds with activities data' do
        activity = create(:activity, name: 'Alola')

        get activities_path

        expect(response.status).to(eq(200))
        expect(body_content["data"]).to(include(JSON.parse(activity.to_json)))
      end
    end

    describe 'POST activites#create' do
      context 'with valid params' do
        it 'creates an activity' do
          post activities_path, params: attributes_for(:activity)

          expect(response.status).to(eq(201))
        end
      end

      context 'with invalid params' do
        it 'does not create an activity and responds with an error' do
          activity_count = Activity.count

          post activities_path, params: { name: '', enabled: true }

          expect(Activity.count).to(eq(activity_count))
          expect(response.status).to(eq(400))
          expect(body_content["message"]).to(include("Name can't be blank"))
        end
      end
    end
  end
end
