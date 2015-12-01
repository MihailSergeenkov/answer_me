require_relative '../acceptance_helper'

feature 'User delete answer', %q{
  I want to delete answer
  As an authenticated user and answer's owner
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  describe 'Authenticated user' do
    context 'Author answer' do
      before do
        sign_in(user)
        visit question_path(question)
      end

      scenario 'sees link to delete your answer' do
        within "#answer-#{answer.id}" do
          expect(page).to have_link 'Delete your answer'
        end
      end

      scenario 'try to delete your answer', js: true do
        within "#answer-#{answer.id}" do
          click_on 'Delete your answer'
        end

        expect(current_path).to eq question_path(question)
        expect(page).to_not have_content answer.body
      end
    end

    context 'Non-author answer' do
      before do
        sign_in(other_user)
        visit question_path(question)
      end

      scenario 'try to delete not your answer' do
        within "#answer-#{answer.id}" do
          expect(page).to_not have_link 'Delete your answer'
        end
      end
    end
  end

  scenario 'Non-authenticated user try to delete answer' do
    visit question_path(question)

    within "#answer-#{answer.id}" do
      expect(page).to_not have_link 'Delete your answer'
    end
  end
end
