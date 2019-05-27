require 'rails_helper'

module LarvataTimesheet
  RSpec.describe(ActivitiesController, type: :request) do
    describe 'GET activities#index' do
      it 'responds with activities data' do
        activity = create(:activity, name: 'Alola')

        get activities_path

        expect(response).to(have_http_status(200))
        expect(body_content["data"]).to(include(JSON.parse(activity.to_json)))
      end
    end

    describe 'POST activites#create' do
      context 'with valid params' do
        it 'creates an activity' do
          post activities_path, params: attributes_for(:activity)

          expect(response).to(have_http_status(201))
        end
      end

      context 'with invalid params' do
        it 'does not create an activity and responds with an error' do
          activity_count = Activity.count

          post activities_path, params: { name: '', enabled: true }

          expect(Activity.count).to(eq(activity_count))
          expect(response).to(have_http_status(400))
          expect(body_content["message"]).to(include("Name can't be blank"))
        end
      end
    end

    describe 'PATCH activities#update' do
      it 'updates an activity' do
        activity = create(:activity, name: 'Personal', enabled: false)

        patch activity_path(activity), params: { enabled: true }

        expect(activity.reload.enabled).to(be(true))
        expect(response).to(have_http_status(200))
      end
    end

    describe 'DELETE activities#destroy' do
      it 'disables a child activity' do
        activity = create(:activity)

        delete activity_path(activity)

        expect(activity.reload.enabled).to(be(false))
        expect(response).to(have_http_status(204))
      end

      it 'disables a parent category and all children' do
        category = create(:activity)
        child_activity = create(:activity, category_id: category.id)

        delete activity_path(category)

        expect(category.reload.enabled).to(be(false))
        expect(child_activity.reload.enabled).to(be(false))
        expect(response).to(have_http_status(204))
      end

      it 'returns an error when the activity does not exist' do
        activity = build(:activity, id: 9001)

        delete activity_path(activity)

        expect(response).to(have_http_status(401))
      end
    end
  end
end
