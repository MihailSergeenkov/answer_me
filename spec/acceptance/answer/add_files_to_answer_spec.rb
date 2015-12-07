require_relative '../acceptance_helper'

feature 'Add files to answer', %q{
  In order to illustrate my answer
  As an answer's author_of
  I'd like to be able to attach files
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { build(:answer, question: question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User adds file when answer to question', js: true do
    within '.new_answer' do
      fill_in 'Body', with: answer.body
      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
      click_on 'Post Your Answer'
    end

    within '.answers' do
      expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
    end
  end
end
