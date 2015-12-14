require_relative '../acceptance_helper'

feature 'Vote for answer', %q{
  In order to distinguish answer
  As an autenticated user
  I can to vote for answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }
  given!(:user_answer) { create(:answer, question: question, user: user) }

  describe 'Autenticated user' do
    before do
      sign_in(user)
      visit question_path(question)

      within "#answer-#{answer.id}" do
        click_link 'Up'
      end
    end

    scenario 'try to vote for answer', js: true do
      within "#answer-#{answer.id}" do
        expect(page).to_not have_selector '.vote-up-on'
        expect(page).to_not have_selector '.vote-down-on'
        expect(page).to have_selector '.vote-up-off'
      end
    end

    scenario 'try to vote up for answer, but later change your mind and vote down', js: true do
      within "#answer-#{answer.id}" do
        click_link 'Delete'
        click_link 'Down'

        expect(page).to_not have_selector '.vote-up-on'
        expect(page).to_not have_selector '.vote-down-on'
        expect(page).to have_selector '.vote-down-off'
      end
    end
  end

  scenario 'Author try to vote for his answer' do
    sign_in(user)
    visit question_path(question)

    within "#answer-#{user_answer.id}" do
      expect(page).to_not have_link 'Up'
      expect(page).to_not have_link 'Down'
    end
  end

  scenario 'Non-autenticated user try to vote for answer' do
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_link 'Up'
      expect(page).to_not have_link 'Down'
    end
  end
end
