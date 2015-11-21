require 'rails_helper'

feature 'User delete answer', %q{
  I want to delete answer
  As an authenticated user and answer's owner
} do

  given(:user) { create(:user) }
  given(:second_user) { create(:user) }
  given(:question) { build(:question) }
  given(:answer) { build(:answer) }

  scenario 'Authenticated user and answer\'s owner try to delete your answer' do
    sign_in(user)

    create_question(question)
    create_and_post_answer
    click_on 'Delete your answer'

    expect(current_path).to eq question_path(Question.last.id)
    expect(page).to have_content 'Your answer is deleted!'
  end

  scenario 'Authenticated user try to delete not your answer' do
    sign_in(user)

    create_question(question)
    create_and_post_answer
    click_on 'Logout'
    sign_in(second_user)
    visit question_path(Question.last.id)

    expect(page).to_not have_button 'Delete your answer'
  end

  scenario 'Non-authenticated user try to delete answer' do
    sign_in(user)

    create_question(question)
    create_and_post_answer
    click_on 'Logout'
    visit question_path(Question.last.id)

    expect(page).to_not have_button 'Delete your answer'
  end
end
