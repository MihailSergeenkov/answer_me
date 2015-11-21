require 'rails_helper'

feature 'User looking question with answers list', %q{
  As an user
  I want to see the question with list of answers
} do

  given(:user) { create(:user) }
  given(:question) { build(:question) }

  scenario 'User try see the question with list of answers' do
    sign_in(user)

    create_question(question)
    create_and_post_answer
    create_and_post_answer(2)

    expect(page).to have_content question.title
    expect(page).to have_content question.body
    expect(page).to have_content 'Answers'
    expect(page).to have_content 'Body of answer the question'
    expect(page).to have_content 'Body of 2nd answer the question'
  end
end
