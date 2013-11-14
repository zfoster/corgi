require 'spec_helper'

describe Identity do

  describe '#update_follows' do
    let(:user) { create(:user) }
    let(:identity) { user.identities.first }
    let(:follow_ids) { ['1', '2'] }

    before do
      identity.should_receive(:followee_ids).and_return(follow_ids)
    end

    it 'should create new follows' do
      expect{identity.update_follows}.to change{user.follows.count}.from(0).to(2)
    end

    it 'should update follows_updated_at' do
      expect{identity.update_follows}.to change{identity.follows_updated_at}
    end
  end

  describe '#link_existing_follows' do
    let(:user_id) { 2 }
    let(:identity) { create(:identity, provider: 'twitter', uid: 'test', user_id: user_id) }
    
    before { create(:follow) }

    it 'should complete the follow' do
      identity.link_existing_follows
      expect(Follow.last.followee_id).to eq(user_id)
    end

  end

  describe '#find_or_create_user' do

    context 'an associated user exists' do
      it 'returns an existing user' do
        user = User.new
        identity = Identity.new( user: user )
        expect(identity.find_or_create_user).to eq(user)
      end
    end

    context 'an associated user does not exist' do
      it 'creates a new user' do
        User.should_receive(:create).with(hash_including(:email, :name))
        identity = Identity.new( info: {} ).find_or_create_user
      end
    end

  end
end
