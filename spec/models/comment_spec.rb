require 'rails_helper'

RSpec.describe Comment, type: :model do
  it_behaves_like 'Userable'

  it { should validate_presence_of :body }
  it { should belong_to :commentable }
end
