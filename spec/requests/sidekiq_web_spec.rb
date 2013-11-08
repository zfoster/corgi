require 'spec_helper'

describe 'Sidekiq' do

  describe 'GET /sidekiq' do

    before do
      get_via_redirect('/auth/facebook')
      User.last.update_attribute(:admin, admin)
    end

    context 'as admin' do
      let(:admin) { true }

      it { get('/sidekiq'); response.response_code.should eq(200) }
    end

    context 'not as admin' do
      let(:admin) { false }

      it { expect{ get('/sidekiq') }.to raise_exception(ActionController::RoutingError) }
    end
  end
end