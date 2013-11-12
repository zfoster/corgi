require 'spec_helper'

describe Rank do
  describe 'calculate_value' do
    let(:user) { create(:user) }
    let(:followee_1) { create(:user) }
    let(:followee_2) { create(:user) }
    let(:followee_3) { create(:user) }
    let(:event) { create(:event) }
    let(:rank) { build(:rank, user: user, event: event)}

    before do
      followee_1.amped_events << event
      followee_2.registered_events << event
      followee_3.hosted_events << event
      user.followed_users << followee_1
      user.followed_users << followee_2
      user.followed_users << followee_3
    end

    it { expect(rank.calculate_value).to eq(7) }
  end

  describe 'update_value' do
  end

  describe 'followed_user_ids' do
    let(:user) { build(:user) }
    let(:rank) { Rank.new(user: user)}

    before do
      user.should_receive :followed_user_ids
    end

    it { rank.followed_user_ids }
  end
end

