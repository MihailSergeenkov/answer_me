shared_examples_for 'Omni Auth User' do
  it 'User already created' do
    do_request
    expect { do_request }.to_not change(User, :count)
  end

  it 'Create new user' do
    expect { do_request }.to change(User, :count).by(1)
  end
end
