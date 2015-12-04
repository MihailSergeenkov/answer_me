require_relative '../acceptance_helper'

feature 'Question editing', %q{
  In order to fix mistake
  As an author of Question
  I did like to be able to edit my question
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:new_question) { build(:question) }

  describe 'Authenticated user' do
    context 'Author question' do
      before do
        sign_in(user)
        visit question_path(question)
      end

      scenario 'try to edit his question', js: true do
        click_on 'Edit question'
        within '.edit-question' do
          fill_in 'Body', with: new_question.body
        end
        click_on 'Save changes'

        expect(page).to_not have_content question.body
        expect(page).to have_content new_question.body
        within '.question' do
          expect(page).to_not have_selector 'textarea'
        end
      end
    end

    context 'Non-author question' do
      before do
        sign_in(other_user)
        visit question_path(question)
      end

      scenario 'try to edit other user\'s question' do
        expect(page).to_not have_link 'Edit question'
      end
    end
  end

  scenario 'Non-authenticated user try to edit question' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit question'
  end
end
