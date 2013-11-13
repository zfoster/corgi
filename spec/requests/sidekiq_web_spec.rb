require 'spec_helper'

describe 'Sidekiq' do

  describe 'GET /sidekiq' do

    context 'as admin' do
      before { sign_in(admin: true) }

      it { get('/sidekiq'); response.response_code.should eq(200) }
    end

    context 'not as admin' do
      before { sign_in }

      it { expect{ get('/sidekiq') }.to raise_exception(ActionController::RoutingError) }
    end
  end
end