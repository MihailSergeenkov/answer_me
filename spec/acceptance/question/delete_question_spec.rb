require 'rails_helper'

feature 'User delete question', %q{
  I want to delete question
  As an authenticated user and question's owner
} do

  given(:user) { create(:user) }
  given(:second_user) { create(:user) }
  given(:question) { build(:question) }

  scenario 'Authenticated user and question\'s owner try to delete your question' do
    sign_in(user)

    create_question(question)
    click_on 'Delete question'

    expect(current_path).to eq questions_path
    expect(page).to have_content 'Your question is deleted!'
    expect(page).to_not have_content question.title
  end

  scenario 'Authenticated user try to delete not your question' do
    sign_in(user)

    create_question(question)
    click_on 'Logout'
    sign_in(second_user)
    visit question_path(Question.last.id)

    expect(page).to_not have_button 'Delete question'
  end

  scenario 'Non-authenticated user try to delete question' do
    sign_in(user)

    create_question(question)
    click_on 'Logout'
    visit question_path(Question.last.id)

    expect(page).to_not have_button 'Delete question'
  end
end
