require_relative '../acceptance_helper'

feature 'Add files to question', %q{
  In order to illustrate my question
  As an question's author
  I'd like to be able to attach files
} do

  given(:user) { create(:user) }
  given(:question) { build(:question, user: user) }

  background do
    sign_in(user)
    visit new_question_path
    fill_in 'Title', with: question.title
    fill_in 'Body', with: question.body
  end

  scenario 'User adds file when asks question', js: true do
    click_on 'Add file'
    attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    click_on 'Post Your Question'

    expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
  end

  scenario 'User adds files when asks question', js: true do
    click_on 'Add file'

    within '.nested-fields' do
      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    end

    click_on 'Add file'

    within '.nested-fields+.nested-fields' do
      attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    end

    click_on 'Post Your Question'

    expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/2/spec_helper.rb'
  end

  scenario 'User adds two files when asks question, but second files delete before save question', js: true do
    click_on 'Add file'

    within '.nested-fields' do
      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    end

    click_on 'Add file'

    within '.nested-fields+.nested-fields' do
      attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
      click_on 'Remove file'
    end

    click_on 'Post Your Question'

    expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'
    expect(page).to_not have_link 'spec_helper.rb', href: '/uploads/attachment/file/2/spec_helper.rb'
  end
end
