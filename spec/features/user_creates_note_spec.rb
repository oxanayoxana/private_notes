# frozen_string_literal: true

require 'rails_helper'

feature 'Create, edit, delete article flow by user: ' do
  let!(:user)       { FactoryBot.create(:user) }
  let!(:note)       { FactoryBot.build(:note, user_id: user.id) }
  let!(:note_2)     { FactoryBot.attributes_for(:note) }

  before do
    visit user_session_path

    within('#new_user') do
      fill_in 'Email',    with: user.email
      fill_in 'Password', with: user.password
    end

    click_button 'Log in'
  end

  context 'create note with valid params' do
    scenario 'adding a new note' do
      visit new_note_path

      fill_in 'Title', with: note.title
      fill_in 'Content', with: note.content

      click_button 'Create Note'

      visit notes_path
      expect(page).to have_content note.title
    end
  end

  context 'create note with invalid params' do
    let!(:note_1) { FactoryBot.build(:note, user_id: user.id) }

    scenario 'adding only a note title' do
      visit new_note_path

      fill_in 'Title', with: note_1.title

      click_button 'Create Note'

      expect(page).to have_content "can't be blank"

      visit notes_path
      expect(page).to have_no_content note_1.title
    end
  end

  context 'modify existing note' do
    let!(:note_3) { FactoryBot.create(:note, user_id: user.id) }

    scenario 'Edit title' do
      visit notes_path
      click_on note_3.title

      click_on 'Edit'

      fill_in 'Title', with: note_2[:title]

      click_button 'Update Note'

      expect(page).to have_content note_2[:title]
    end

    scenario 'delete a note' do
      visit notes_path
      click_on note_3.title

      expect(page).to have_content note_3.title

      click_on 'Delete'

      expect(page).to have_no_content note_3.title
    end
  end
end
