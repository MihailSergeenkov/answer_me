require 'rails_helper'

feature 'User edit question', %q{
  I want to edit question
  As an authenticated user and question's owner
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:new_question) { build(:question) }

  scenario 'Authenticated user and question\'s owner try to edit your question' do
    sign_in(user)

    create_question(question)
    click_on 'Edit question'
    fill_in 'Body', with: new_question.body
    click_on 'Save changes'

    expect(current_path).to eq question_path(Question.last.id)
    expect(page).to have_content 'Your question is saved!'
    expect(page).to_not have_content question.body
    expect(page).to have_content new_question.body
  end

  scenario 'Authenticated user try to edit not your question' do
    sign_in(other_user)
    visit question_path(question)

    expect(page).to_not have_button 'Edit question'
  end

  scenario 'Non-authenticated user try to edit question' do
    visit question_path(question)

    expect(page).to_not have_button 'Edit question'
  end
end
