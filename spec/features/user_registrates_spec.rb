# frozen_string_literal: true

require 'rails_helper'

feature 'User registration:' do
  let!(:user)        { FactoryBot.build(:user) }
  let!(:user_1)      { FactoryBot.create(:user) }
  let!(:user_2)      { FactoryBot.build(:user) }
  let!(:fake_email)    { 'hello@' }
  let!(:fake_password) { '1234' }

  context 'with valid params' do
    scenario 'allows user to sign up' do
      visit new_user_registration_path

      fill_in 'Email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'Password confirmation', with: user.password

      click_button 'Sign up'

      expect(page).to have_content 'Welcome! You have signed up successfully'
    end
  end

  context 'with invalid params' do
    scenario 'without password' do
      visit new_user_registration_path

      fill_in 'Email', with: user_2.email

      click_button 'Sign up'

      expect(page).to have_content "can't be blank"
    end

    scenario 'without email' do
      visit new_user_registration_path

      fill_in 'user_password', with: user_2.password
      fill_in 'Password confirmation', with: user_2.password

      click_button 'Sign up'

      expect(page).to have_content "can't be blank"
    end

    scenario 'with email that is already used' do
      visit new_user_registration_path

      fill_in 'Email', with: user_1.email

      click_button 'Sign up'

      expect(page).to have_content 'has already been taken'
    end

    scenario 'with existing email in different letters case' do
      visit new_user_registration_path

      fill_in 'Email', with: user_1.email.upcase

      click_button 'Sign up'

      expect(page).to have_content 'has already been taken'
    end
  end

  context 'with invalid email' do
    scenario 'it shows errors' do
      visit new_user_registration_path

      fill_in 'Email', with: fake_email

      click_button 'Sign up'

      expect(page).to have_content 'is invalid'
    end
  end

  context 'when password is too short' do
    scenario 'it shows errors' do
      visit new_user_registration_path

      fill_in 'user_password', with: fake_password
      fill_in 'Password confirmation', with: fake_password

      click_button 'Sign up'

      expect(page).to have_content 'too short (minimum is 6 characters)'
    end
  end
end
