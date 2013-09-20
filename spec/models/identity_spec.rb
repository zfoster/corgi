require 'spec_helper'

describe Identity do
  describe "self.find_or_create_with_omniauth" do

  end

  describe "find_or_create_user" do

    context 'an associated user exists' do
      it 'returns an existing user' do
        user = User.new
        identity = Identity.new( user: user )
        expect(identity.find_or_create_user).to eq(user)
      end
    end

    context 'an associated user does not exist' do
      let(:auth_response) { OmniAuth.config.mock_auth[:facebook] }

      it 'creates a new user' do
        User.should_receive(:create).with(hash_including(:email, :first_name, :last_name))
        identity = Identity.new( auth_response: auth_response ).find_or_create_user
      end
    end

  end
end