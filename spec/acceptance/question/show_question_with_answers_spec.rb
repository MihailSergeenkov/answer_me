require_relative '../acceptance_helper'

feature 'User looking question with answers list', %q{
  As an user
  I want to see the question with list of answers
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answers) { create_list(:answer, 2, question: question) }

  scenario 'User try see the question with list of answers' do
    sign_in(user)
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body
    expect(page).to have_content 'Answers'
    answers.each { |answer| expect(page).to have_content answer.body }
  end
end
