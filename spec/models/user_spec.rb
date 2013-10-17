require 'spec_helper'

describe User do
  describe '#display_name' do
    let(:user) { build(:user) }
    subject {user.display_name}

    it { should eq("Bob Loblaw") }

    # context 'a user only authd with Twitter' do
    #   let(:user) { create(:user, first_name: nil, last_name: nil, services: [ :twitter ]) }
    #   it { should eq("Fail Whale") }
    # end
  end
  
end