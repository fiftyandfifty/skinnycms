require 'spec_helper'

describe Category do
  
  before(:each) do
    @category = Factory(:category)
  end
  
  subject { @category }

  describe "when creating" do
    context 'validates' do
      it { should be_valid }
      it { should validate_presence_of :name }
      it { should validate_uniqueness_of(:name).case_insensitive }
    end
  end

  describe "associations" do
    it { should have_many(:category_items) }
  end
end