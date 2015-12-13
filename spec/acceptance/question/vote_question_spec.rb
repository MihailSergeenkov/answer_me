require_relative '../acceptance_helper'

feature 'Vote for question', %q{
  In order to distinguish question
  As an autenticated user
  I can to vote for question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given(:user_question) { create(:question, user: user) }

  describe 'Autenticated user' do
    before do
      sign_in(user)
      visit question_path(question)
      click_link 'Up'
    end

    scenario 'try to vote for question', js: true do
      expect(page).to_not have_selector '.vote-up-on'
      expect(page).to_not have_selector '.vote-down-on'
      expect(page).to have_selector '.vote-up-off'
    end

    scenario 'try to vote up for question, but later change your mind and vote down', js: true do
      click_link 'Delete'
      click_link 'Down'

      expect(page).to_not have_selector '.vote-up-on'
      expect(page).to_not have_selector '.vote-down-on'
      expect(page).to have_selector '.vote-down-off'
    end
  end

  scenario 'Author try to vote for his question' do
    sign_in(user)
    visit question_path(user_question)

    expect(page).to_not have_link 'Up'
    expect(page).to_not have_link 'Down'
  end

  scenario 'Non-autenticated user try to vote for question' do
    visit question_path(question)

    expect(page).to_not have_link 'Up'
    expect(page).to_not have_link 'Down'
  end
end
