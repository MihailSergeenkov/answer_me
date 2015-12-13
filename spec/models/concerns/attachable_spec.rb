require 'rails_helper'

describe Question do
  it_behaves_like 'Attachable'
end

describe Answer do
  it_behaves_like 'Attachable'
end
