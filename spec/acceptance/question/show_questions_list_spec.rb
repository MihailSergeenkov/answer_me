require 'rails_helper'

feature 'User looking questions list', %q{
  As an user
  I want to see the list of questions
} do

  given(:user) { create(:user) }
  given(:questions) { create_list(:question, 2, user: user) }

  scenario "User try to see the list of questions" do
    sign_in(user)

    questions.each { |question| create_question(question) }
    visit questions_path

    questions.each { |question| expect(page).to have_content question.title }
  end
end
