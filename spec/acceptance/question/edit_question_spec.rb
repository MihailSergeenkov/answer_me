require 'rails_helper'

feature 'User edit question', %q{
  I want to edit question
  As an authenticated user and question's owner
} do

  given(:user) { create(:user) }
  given(:second_user) { create(:user) }
  given(:question) { build(:question) }

  scenario 'Authenticated user and question\'s owner try to edit your question' do
    sign_in(user)

    create_question(question)
    click_on 'Edit question'
    fill_in 'Body', with: 'Edit question'
    click_on 'Save changes'

    expect(current_path).to eq question_path(Question.last.id)
    expect(page).to have_content 'Your question is saved!'
  end

  scenario 'Authenticated user try to edit not your question' do
    sign_in(user)

    create_question(question)
    click_on 'Logout'
    sign_in(second_user)
    visit question_path(Question.last.id)

    expect(page).to_not have_button 'Edit question'
  end

  scenario 'Non-authenticated user try to edit question' do
    sign_in(user)

    create_question(question)
    click_on 'Logout'
    visit question_path(Question.last.id)

    expect(page).to_not have_button 'Edit question'
  end
end
