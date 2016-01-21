require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it_behaves_like 'Userable'
  
  it { should belong_to :question }
  it { should validate_presence_of :question_id }
end
