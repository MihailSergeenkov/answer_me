require_relative '../acceptance_helper'

feature 'Delete comment from question', %q{
  In order to revoke comment for question
  As an author of comment
  I'd like to delete comment question
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question) }
  given!(:comment) { create(:question_comment, commentable: question, user: user) }

  describe 'Authenticate user' do
    scenario 'try to delete his comment', js: true do
      sign_in(user)
      visit question_path(question)

      within "#comment-#{comment.id}" do
        click_on 'Delete comment'
      end

      within '.comments' do
        expect(page).to_not have_content comment.body
      end
    end

    scenario 'try to delete other comment' do
      sign_in(other_user)
      visit question_path(question)

      within '.comments' do
        expect(page).to_not have_content 'Delete comment'
      end
    end
  end

  scenario 'Non-authenticate user try to comment the question' do
    visit question_path(question)

    expect(page).to_not have_content 'Delete comment'
  end
end
