require 'rails_helper'

feature 'User create question', %q{
  I want to ask question
} do

  scenario 'User try to create question' do
    visit new_question_path

    fill_in 'Title', with: 'My question'
    fill_in 'Body', with: 'Body of question'

    click_on 'Post Your Question'

    expect(current_path).to eq question_path(Question.last.id)
    expect(page).to have_content 'Thanks! Your question is saved!'
  end

  scenario 'User try to create question with empty title' do
    visit new_question_path

    fill_in 'Title', with: nil
    fill_in 'Body', with: 'Body of question'

    click_on 'Post Your Question'

    expect(current_path).to eq questions_path
    expect(page).to have_content 'Please, enter the correct data!'
  end

  scenario 'User try to create question with empty body' do
    visit new_question_path

    fill_in 'Title', with: 'My question'
    fill_in 'Body', with: nil

    click_on 'Post Your Question'

    expect(current_path).to eq questions_path
    expect(page).to have_content 'Please, enter the correct data!'
  end
end
