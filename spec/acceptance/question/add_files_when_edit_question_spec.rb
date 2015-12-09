require_relative '../acceptance_helper'

feature 'Add files to question when edit question', %q{
  In order to illustrate my question
  As an question's author
  I'd like to be able to attach files when edit question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'Author question edit question for add files', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Edit question'
    within '.edit-question' do
      click_on 'Add file'
      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    end
    click_on 'Save changes'

    visit question_path(question) # Жуткий костыль

    expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
  end
end
