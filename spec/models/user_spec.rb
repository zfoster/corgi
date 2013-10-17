require 'spec_helper'

describe User do
  describe '#display_name' do
    it 'returns a name' do
      user = build(:user)
      my_name = user.display_name
      expect(my_name).to eq("Bob Loblaw")
    end
  end
  
end