module AcceptanceHelpers
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def sign_up(user)
    visit new_user_session_path
    click_on 'Sign up'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password

    click_on 'Sign up'
  end

  def create_question(question)
    visit questions_path

    click_on 'Ask question'
    fill_in 'Title', with: question.title
    fill_in 'Body', with: question.body

    click_on 'Post Your Question'
  end

  def create_and_post_answer(number = nil)
    click_on 'Create Your Answer'
    fill_in 'Body', with: "Body of #{number && number.ordinalize} answer the question"
    click_on 'Post Your Answer'
  end
end
