require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PageContent do

  before(:each) do
    @page = Factory(:page)
    @page_content = Factory(:page_content, :page_id => @page.id)
  end

  subject { @page_content }

  describe "when creating" do
    context 'validates' do
      it { should be_valid }
      it { should validate_presence_of :page_id }
      it { should validate_presence_of :location }
    end
  end

  describe "associations" do
    it { should belong_to(:page) }
  end
end