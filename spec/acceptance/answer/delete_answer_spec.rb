require 'rails_helper'

feature 'User delete answer', %q{
  I want to delete answer
  As an authenticated user and answer's owner
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Authenticated user and answer\'s owner try to delete your answer' do
    sign_in(user)
    visit question_path(question)
    click_on 'Delete your answer'

    expect(current_path).to eq question_path(Question.last.id)
    expect(page).to have_content 'Your answer is deleted!'
    expect(page).to_not have_content answer.body
  end

  scenario 'Authenticated user try to delete not your answer' do
    sign_in(other_user)
    visit question_path(question)

    expect(page).to_not have_button 'Delete your answer'
  end

  scenario 'Non-authenticated user try to delete answer' do
    visit question_path(question)

    expect(page).to_not have_button 'Delete your answer'
  end
end
