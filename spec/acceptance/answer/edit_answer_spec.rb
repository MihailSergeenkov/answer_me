require 'rails_helper'

feature 'User edit answer', %q{
  I want to edit answer
  As an authenticated user and answer's owner
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, question: question, user: user) }
  given(:new_answer) { build(:answer, question: question, user: user) }

  scenario 'Authenticated user and answer\'s owner try to edit your answer' do
    sign_in(user)

    create_question(question)
    create_answer(answer)

    click_on 'Edit your answer'
    fill_in 'Body', with: new_answer.body
    click_on 'Save changes'

    expect(current_path).to eq question_path(Question.last.id)
    expect(page).to have_content 'Your answer is saved!'
    expect(page).to_not have_content answer.body
    expect(page).to have_content new_answer.body
  end

  scenario 'Authenticated user try to edit not your answer' do
    sign_in(other_user)
    answer
    visit question_path(question)

    expect(page).to_not have_button 'Edit your answer'
  end

  scenario 'Non-authenticated user try to edit answer' do
    answer
    visit question_path(question)

    expect(page).to_not have_button 'Edit your answer'
  end
end
