require 'rails_helper'

feature 'User looking questions list', %q{
  As an user
  I want to see the list of questions
} do

  given(:user) { create(:user) }
  given(:question) { build(:question) }
  given(:second_question) { build(:question) }

  scenario "User try to see the list of questions" do
    sign_in(user)

    create_question(question)

    create_question(second_question)

    visit questions_path

    expect(page).to have_content question.title
    expect(page).to have_content question.body
    expect(page).to have_content second_question.title
    expect(page).to have_content second_question.body
  end
end
