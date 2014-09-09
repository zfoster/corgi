require 'spec_helper'

describe User do

  describe 'before_create' do

    let(:user) { create(:user) }

    it 'updates user name attributes' do
      expect(user.first_name).to eq('Bob')
    end
  end
end