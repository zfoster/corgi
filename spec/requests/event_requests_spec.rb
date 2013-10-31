require 'spec_helper'

describe 'EventRequests' do

  let(:event) { create(:event) }

  describe 'GET attendees_csv' do
    it 'gets a csv of attendees' do
      file_name = 'data.csv'
      get event_registrations_path(event, format: :csv)
      response.content_type.should eq("text/csv")
      response.headers["Content-Disposition"].should eq("attachment; filename=#{file_name}")
    end
  end

  describe 'GET new' do
    it 'should redirect to an authorization page' do
      get new_event_path
      expect(response).to redirect_to(identities_path)
    end
  end
end