require 'rails_helper'

feature 'User create answer', %q{
  As an user
  I want to answer the question
} do

  scenario 'User try to create answer the question' do
    visit new_question_path
    fill_in 'Title', with: 'My question'
    fill_in 'Body', with: 'Body of question'

    click_on 'Post Your Question'

    click_on 'Create Your Answer'
    fill_in 'Body', with: 'Body of answer the question'
    click_on 'Post Your Answer'

    expect(current_path).to eq question_path(Question.last.id)
  end

  scenario 'User try to create answer the question with empty body' do
    visit new_question_path
    fill_in 'Title', with: 'My question'
    fill_in 'Body', with: 'Body of question'

    click_on 'Post Your Question'

    click_on 'Create Your Answer'
    fill_in 'Body', with: nil
    click_on 'Post Your Answer'

    expect(current_path).to eq question_answers_path(Question.last.id)
    expect(page).to have_content 'Please, enter the correct data!'
  end
end
