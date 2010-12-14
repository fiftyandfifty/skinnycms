require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Page do

  before(:each) do
    @page = Factory(:page)
  end

  subject { @page }

  describe "when creating" do

    it { should be_valid }

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:permalink) }
    
  end
end