require_relative '../acceptance_helper'

feature 'Subscribe for question', %q{
  In order to be able to subscribe for update question
  As an autenticated user
  I can to subscribe for question
} do

  given!(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:user_question) { create(:question, user: user) }
  given!(:subscription) { create(:subscription, question: user_question, user: user) }

  describe 'Autenticated user' do
    before do
      sign_in(user)
      visit question_path(question)
      click_on 'Subscribe'
    end

    scenario 'subscribe for question', js: true do
      expect(page).to have_content 'Unsubscribe'
      expect(page).to_not have_content 'Subscribe'
    end

    scenario 'unsubscribe for question', js: true do
      click_on 'Unsubscribe'

      expect(page).to have_content 'Subscribe'
      expect(page).to_not have_content 'Unsubscribe'
    end
  end

  scenario 'Author try to subscribe for his question' do
    sign_in(user)
    visit question_path(user_question)

    expect(page).to_not have_content 'Subscribe'
    expect(page).to have_content 'Unsubscribe'
  end

  scenario 'Non-autenticated user try to subscribe for question' do
    visit question_path(question)

    expect(page).to_not have_content 'Subscribe'
  end
end
