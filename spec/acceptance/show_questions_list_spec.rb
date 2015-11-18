require 'rails_helper'

feature 'User looking questions list', %q{
  As an user
  I want to see the list of questions
} do

  scenario "User try to see the list of questions" do
    visit new_question_path
    fill_in 'Title', with: 'My question'
    fill_in 'Body', with: 'Body of question'

    click_on 'Post Your Question'

    visit new_question_path
    fill_in 'Title', with: 'My question 2'
    fill_in 'Body', with: 'Body of question 2'

    click_on 'Post Your Question'

    visit questions_path

    expect(page).to have_content 'My question'
    expect(page).to have_content 'Body of question'
    expect(page).to have_content 'My question 2'
    expect(page).to have_content 'Body of question 2'
  end
end
