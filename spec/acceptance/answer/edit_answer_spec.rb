require 'rails_helper'

feature 'User edit answer', %q{
  I want to edit answer
  As an authenticated user and answer's owner
} do

  given(:user) { create(:user) }
  given(:second_user) { create(:user) }
  given(:question) { build(:question) }
  given(:answer) { build(:answer) }

  scenario 'Authenticated user and answer\'s owner try to edit your answer' do
    sign_in(user)

    create_question(question)
    create_and_post_answer

    click_on 'Edit your answer'
    fill_in 'Body', with: 'Edit question'
    click_on 'Save changes'

    expect(current_path).to eq question_path(Question.last.id)
    expect(page).to have_content 'Your answer is saved!'
    expect(page).to_not have_content 'Body of answer the question'
    expect(page).to have_content 'Edit question'
  end

  scenario 'Authenticated user try to edit not your answer' do
    sign_in(user)

    create_question(question)
    create_and_post_answer
    click_on 'Logout'
    sign_in(second_user)
    visit question_path(Question.last.id)

    expect(page).to_not have_button 'Edit your answer'
  end

  scenario 'Non-authenticated user try to edit answer' do
    sign_in(user)

    create_question(question)
    create_and_post_answer
    click_on 'Logout'
    visit question_path(Question.last.id)

    expect(page).to_not have_button 'Edit your answer'
  end
end
