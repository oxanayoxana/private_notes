# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can access admin panel: ' do
  let!(:admin)       { FactoryBot.create(:user, admin: true) }

  # before do
  #   visit user_session_path

  #   within('#new_user') do
  #     fill_in 'Email',    with: admin.email
  #     fill_in 'Password', with: admin.password
  #   end

  #   click_button 'Log in'
  # end

  context 'admin can visit admin panel' do
    scenario 'adding a new note' do
      visit user_session_path

      within('#new_user') do
        fill_in 'Email',    with: admin.email
        fill_in 'Password', with: admin.password
      end

      click_button 'Log in'

      visit rails_admin_path

      expect(page).to have_content 'Site Administration'
    end
  end

  context 'ordinary user can not visit admin panel' do
    let!(:user) { FactoryBot.create(:user) }

    scenario 'adding a new note' do
      visit user_session_path

      within('#new_user') do
        fill_in 'Email',    with: user.email
        fill_in 'Password', with: user.password
      end

      click_button 'Log in'

      visit rails_admin_path

      expect(page).to have_content 'New Note'
    end
  end
end
