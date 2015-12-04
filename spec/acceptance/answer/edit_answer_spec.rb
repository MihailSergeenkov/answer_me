require_relative '../acceptance_helper'

feature 'Answer editing', %q{
  In order to fix mistake
  As an author of Answer
  I did like to be able to edit my answer
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }
  given(:new_answer) { build(:answer, question: question, user: user) }

  describe 'Authenticated user' do
    context 'Author answer' do
      before do
        sign_in(user)
        visit question_path(question)
      end

      scenario 'try to edit his answer', js: true do
        click_on 'Edit your answer'
        within '.answers' do
          fill_in 'Body', with: new_answer.body
        end
        click_on 'Save changes'

        expect(page).to_not have_content answer.body
        expect(page).to have_content new_answer.body
        within '.answers' do
          expect(page).to_not have_selector 'textarea'
        end
      end

      scenario 'try to edit his answer with invalid body', js: true do
        click_on 'Edit your answer'
        within '.answers' do
          fill_in 'Body', with: nil
        end
        click_on 'Save changes'

        expect(page).to have_content answer.body
        within '.answers' do
          expect(page).to have_selector 'textarea'
          expect(page).to have_content 'Body can\'t be blank'
        end
      end
    end

    context 'Non-author answer' do
      before do
        sign_in(other_user)
        visit question_path(question)
      end

      scenario 'try to edit other user\'s answer' do
        expect(page).to_not have_link 'Edit your answer'
      end
    end

    context 'Non-author and author answer' do
      given!(:answer_by_other_user) { create(:answer, question: question, user: other_user) }

      before do
        sign_in(other_user)
        visit question_path(question)
      end

      scenario 'sees link to edit his answer, but doesn\'t see edit link to other user\'s answer' do
        within "#answer-#{answer.id}" do
          expect(page).to_not have_link 'Edit your answer'
        end

        within "#answer-#{answer_by_other_user.id}" do
          expect(page).to have_link 'Edit your answer'
        end
      end
    end
  end

  scenario 'Non-authenticated user try to edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit your answer'
  end
end
