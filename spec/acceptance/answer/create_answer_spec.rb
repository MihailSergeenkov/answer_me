require_relative '../acceptance_helper'

feature 'User create answer', %q{
  As an user
  I want to answer the question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }
  given!(:invalid_answer) { build(:invalid_answer, question: question) }

  scenario 'User try to create answer the question', js: true do
    sign_in(user)
    visit question_path(question)

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content answer.body
    end
  end

  scenario 'User try to create invalid answer in question', js: true do
    sign_in(user)
    visit question_path(question)

    click_on 'Post Your Answer'

    expect(page).to have_content 'Body can\'t be blank'
  end
end
