require 'rails_helper'

RSpec.describe Vote do
    it_behaves_like 'Userable'
    
    it { should belong_to :votable }
    it { should validate_inclusion_of(:value).in_array([1, -1]) }
end
