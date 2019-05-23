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
  end
end
