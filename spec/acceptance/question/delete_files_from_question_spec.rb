require_relative '../acceptance_helper'

feature 'Delete files from question', %q{
  In order to change mistake files
  As an question's author
  I'd like to be able to delete files
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:question_with_file) { create(:question_attachment, attachable: question) }

  scenario 'User delete mistake file after ask question', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Delete file'

    expect(page).to_not have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
  end

  scenario 'Authenticated user try to delete mistake file from question' do
    sign_in(other_user)
    visit question_path(question)

    expect(page).to_not have_link 'Delete file'
  end
  scenario 'Non-authenticated user try to delete mistake file from question' do
    visit question_path(question)

    expect(page).to_not have_link 'Delete file'
  end
end
