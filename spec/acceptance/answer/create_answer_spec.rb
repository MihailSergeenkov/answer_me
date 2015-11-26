require 'rails_helper'

feature 'User create answer', %q{
  As an user
  I want to answer the question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }
  given(:invalid_answer) { build(:invalid_answer, question: question) }

  scenario 'User try to create answer the question' do
    sign_in(user)
    visit question_path(question)

    expect(current_path).to eq question_path(Question.last.id)
    expect(page).to have_content answer.body
  end

  scenario 'User try to create answer the question with empty body' do
    sign_in(user)
    visit question_path(question)
    create_answer(invalid_answer)

    expect(current_path).to eq question_answers_path(Question.last.id)
    expect(page).to have_content 'Please, enter the correct data!'
  end
end
