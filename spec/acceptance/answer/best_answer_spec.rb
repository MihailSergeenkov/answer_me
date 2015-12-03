require_relative '../acceptance_helper'

feature 'Best answer', %q{
  In order to mark the answer
  Author can mark the answer as the best answer
  Best answer can be only one
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:other_user_question) { create(:question, user: other_user) }
  given!(:answer) { create(:answer, question: question, user: user) }
  given(:second_answer) { create(:answer, question: question, user: user) }

  describe 'Authenticated user' do
    context 'Author question' do
      before do
        sign_in(user)
        visit question_path(question)
      end

      scenario 'sees the link for assign the best answer' do
        within "#answer-#{answer.id}" do
          expect(page).to have_link 'Make Best'
        end
      end

      scenario 'try to assign the best answer', js: true do
        within "#answer-#{answer.id}" do
          click_on 'Make Best'
        end

        expect(page).to have_selector ".best-answer#answer-#{answer.id}"
      end

      scenario 'try to re-assign the best answer', js: true do
        within "#answer-#{answer.id}" do
          click_on 'Make Best'
        end

        within "#answer-#{second_answer.id}" do
          click_on 'Make Best'
        end

        expect(page).to_not have_selector ".best-answer#answer-#{answer.id}"
        expect(page).to have_selector ".best-answer#answer-#{second_answer.id}"
      end

      scenario 'the best answer first in answers list', js: true do
        within "#answer-#{answer.id}" do
          click_on 'Make Best'
        end

        within "#best" do
          expect(page).to have_selector ".best-answer#answer-#{answer.id}"
        end
      end
    end

    context 'Non-author question' do
      before do
        sign_in(user)
        visit question_path(other_user_question)
      end

      scenario 'doesn\'t see the link for assign the best answer other user\'s question' do
        expect(page).to_not have_link 'Make Best'
      end
    end
  end

  scenario 'Non-authenticated user doesn\'t see the link for assign the best answer' do
    visit question_path(question)

    within "#answer-#{answer.id}" do
      expect(page).to_not have_link 'Make Best'
    end
  end
end
