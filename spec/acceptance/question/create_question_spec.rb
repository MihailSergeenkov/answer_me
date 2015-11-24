require 'rails_helper'

feature 'User create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask questions
} do

  given(:user) { create(:user) }
  given(:question) { build(:question) }

  scenario 'Authenticated user try to create question' do
    sign_in(user)

    create_question(question)

    expect(current_path).to eq question_path(Question.last.id)
    expect(page).to have_content 'Thanks! Your question is saved!'
    expect(page).to have_content question.title
    expect(page).to have_content question.body
  end

  scenario 'Authenticated user try to create question with empty title' do
    sign_in(user)

    visit questions_path

    click_on 'Ask question'
    fill_in 'Title', with: nil
    fill_in 'Body', with: 'Body of question'

    click_on 'Post Your Question'

    expect(current_path).to eq questions_path
    expect(page).to have_content 'Please, enter the correct data!'
  end

  scenario 'Non-authenticated user try to create question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
