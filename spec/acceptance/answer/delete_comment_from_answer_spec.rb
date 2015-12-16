require_relative '../acceptance_helper'

feature 'Delete comment from answer', %q{
  In order to revoke comment for answer
  As an author of comment
  I'd like to delete comment answer
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }
  given!(:comment) { create(:answer_comment, commentable: answer, user: user) }

  describe 'Authenticate user' do
    scenario 'try to delete his comment', js: true do
      sign_in(user)
      visit question_path(question)

      within '.answers' do
        within "#comment-#{comment.id}" do
          click_on 'Delete comment'
        end

        within '.comments' do
          expect(page).to_not have_content comment.body
        end
      end
    end

    scenario 'try to delete other comment' do
      sign_in(other_user)
      visit question_path(question)

      within '.answers' do
        within '.comments' do
          expect(page).to_not have_content 'Delete comment'
        end
      end
    end
  end

  scenario 'Non-authenticate user try to comment the answer' do
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_content 'Delete comment'
    end
  end
end
