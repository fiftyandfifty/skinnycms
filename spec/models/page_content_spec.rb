require 'spec_helper'

describe PageContent do

  before(:each) do
    @page = Factory(:page)
    @page_content = Factory(:page_content, :page_id => @page.id)
  end

  subject { @page_content }

  describe "when creating" do

    it { should be_valid }

    it { should validate_presence_of(:page_id) }
    it { should validate_presence_of(:location) }

  end
end