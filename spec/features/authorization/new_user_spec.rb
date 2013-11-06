require 'spec_helper'

describe "A new user authorizes" do
  let(:name) { OmniAuth.config.mock_auth[provider.intern].info.name }
  let(:nickname) { OmniAuth.config.mock_auth[provider.intern].info.nickname }

  context 'with facebook' do
    let(:provider) { 'facebook' }

    it "shows my authorized accounts" do
      visit root_path
      click_link 'Connect with Facebook'
      expect(page.find('.facebook')).to have_content(name)
    end
  end

  context 'with twitter' do
    let(:provider) { 'twitter' }

    it "asks for email if needed" do
      visit root_path
      click_link 'Connect with Twitter'
      fill_in 'twitter-email', with: 'bob@example.com'
      click_on 'Save Email'
      expect(page.find('.twitter')).to have_content(nickname)
      expect(page.find('.twitter')).to have_content(name)
    end

    it "does not ask for email if it already exists" do
      visit root_path
      click_link 'Connect with LinkedIn'
      click_link 'Connect with Twitter'
      expect(current_path).to eq(root_path)
    end
  end

  context 'with linkedin' do
    let(:provider) { 'linkedin' }

    it "shows my authorized accounts" do
      visit root_path
      click_link 'Connect with LinkedIn'
      expect(page.find('.linkedin')).to have_content(name)
    end
  end

  context 'with googleplus' do
    let(:provider) { 'google' }

    it "shows my authorized accounts" do
      visit root_path
      click_link 'Connect with Google'
      expect(page.find('.googleplus')).to have_content(name)
    end
  end

  context 'with multiple providers' do
    let(:providers) { ['facebook', 'twitter', 'linkedin'] }

    it "shows my authorized accounts" do
      visit root_path
      click_link 'Connect with Facebook'
      click_link 'Connect with Twitter'
      click_link 'Connect with LinkedIn'
      providers.each do |provider|
        expect(page.find(".facebook")).to have_content(OmniAuth.config.mock_auth[provider.intern].info.name)
        expect(page.find(".twitter")).to have_content(OmniAuth.config.mock_auth[provider.intern].info.name)
        expect(page.find(".linkedin")).to have_content(OmniAuth.config.mock_auth[provider.intern].info.name)
      end
    end
  end

end