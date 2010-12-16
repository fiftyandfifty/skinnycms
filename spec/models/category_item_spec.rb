require 'spec_helper'

describe CategoryItem do
  
  before(:each) do
    @category = Factory(:category)
    @category_item = Factory(:category_item, :category_id => @category.id, :categorizable_id => @category.id)
  end
  
  subject { @category_item }

  describe "when creating" do
    context 'validates' do
      it { should be_valid }
      it { should validate_presence_of :category_id }
      it { should validate_presence_of :categorizable_type }
      it { should validate_presence_of :categorizable_id }
    end
  end

  describe "associations" do
    it { should belong_to(:category) }
  end
end