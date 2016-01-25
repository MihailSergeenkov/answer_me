require_relative '../acceptance_helper'
require_relative '../sphinx_helper'

feature 'User search anything' do
  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer) }
  given!(:question_comment) { create(:question_comment) }

  background do
    index
    visit root_path
  end

  scenario 'User want to search questions', js: true do
    fill_in 'query', with: question.title.slice(0..1)
    select('Questions', from: 'condition')
    click_on 'Search'

    expect(current_path).to eq search_path
    within '.results' do
      expect(page).to have_content question.id
    end
  end

  scenario 'User want to search answers', js: true do
    fill_in 'query', with: answer.body.slice(0..1)
    select('Answers', from: 'condition')
    click_on 'Search'

    expect(current_path).to eq search_path
    within '.results' do
      expect(page).to have_content answer.id
    end
  end

  scenario 'User want to search comments', js: true do
    fill_in 'query', with: question_comment.body.slice(0..1)
    select('Comments', from: 'condition')
    click_on 'Search'

    expect(current_path).to eq search_path
    within '.results' do
      expect(page).to have_content question_comment.id
    end
  end

  scenario 'User want to search users', js: true do
    fill_in 'query', with: user.email.split('@').first
    select('Users', from: 'condition')
    click_on 'Search'

    expect(current_path).to eq search_path
    within '.results' do
      expect(page).to have_content user.email
    end
  end

  scenario 'User want to search anything', js: true do
    select('Anything', from: 'condition')
    click_on 'Search'

    expect(current_path).to eq search_path
    within '.results' do
      expect(page).to have_content question.id
      expect(page).to have_content answer.id
      expect(page).to have_content question_comment.id
      expect(page).to have_content user.email
    end
  end
end
