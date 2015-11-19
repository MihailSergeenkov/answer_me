require 'rails_helper'

feature 'User looking question with answers list', %q{
  As an user
  I want to see the question with list of answers
} do

  scenario 'User try see the question with list of answers' do
    visit new_question_path
    fill_in 'Title', with: 'My question'
    fill_in 'Body', with: 'Body of question'

    click_on 'Post Your Question'

    click_on 'Create Your Answer'
    fill_in 'Body', with: 'Body of answer the question'
    click_on 'Post Your Answer'

    click_on 'Create Your Answer'
    fill_in 'Body', with: 'Body of second answer the question'
    click_on 'Post Your Answer'

    expect(page).to have_content 'My question'
    expect(page).to have_content 'Body of question'
    expect(page).to have_content 'Answers'
    expect(page).to have_content 'Body of answer the question'
    expect(page).to have_content 'Body of second answer the question'
  end
end
