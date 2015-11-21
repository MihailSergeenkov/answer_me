require 'rails_helper'

feature 'User create answer', %q{
  As an user
  I want to answer the question
} do

  given(:user) { create(:user) }
  given(:question) { build(:question) }

  scenario 'User try to create answer the question' do
    sign_in(user)

    create_question(question)
    create_and_post_answer

    expect(current_path).to eq question_path(Question.last.id)
  end

  scenario 'User try to create answer the question with empty body' do
    sign_in(user)

    create_question(question)

    click_on 'Create Your Answer'
    fill_in 'Body', with: nil
    click_on 'Post Your Answer'

    expect(current_path).to eq question_answers_path(Question.last.id)
    expect(page).to have_content 'Please, enter the correct data!'
  end
end
