require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do 
  
  before(:each) do
    @user = Factory(:user)
  end
  
  subject { @user }

  describe "when creating" do
    context 'validates' do
      it { should be_valid }

      it { should validate_presence_of :name }

      it { should validate_presence_of :email }

      it { should validate_presence_of :password }

      it { should validate_presence_of :password_confirmation }

      it { should validate_uniqueness_of(:email).case_insensitive }

      it "should accept valid email addresses" do
        addresses = %w[user@foobar.com user@foobar.com.mx uramirez@mail.utexas.edu foo.bar@foo.com.mx]
        addresses.each do |address|
          valid_email_user = Factory(:user, :email => address)
          valid_email_user.should be_valid
        end
      end

      it "should reject invalid email addresses" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
        addresses.each do |address|
          invalid_email_user = Factory.build(:user, :email => address)
          invalid_email_user.should_not be_valid
        end
      end

      it "should reject email addresses identical up to case" do
        upcased_email = @user.email.upcase
        user_with_upcased_email = Factory.build(:user, :email => upcased_email)
        user_with_upcased_email.should_not be_valid
      end

      it "should reject short passwords" do
        short_password = "a" * 5
        user_with_short_password = Factory.build(:user, :password => short_password, :password_confirmation => short_password)
        user_with_short_password.should_not be_valid
      end

      it "should reject long passwords" do
        long_password = "a" * 25
        user_with_long_password = Factory.build(:user, :password => long_password, :password_confirmation => long_password)
        user_with_long_password.should_not be_valid
      end

      it "should have idential password and password_confirmation" do
        valid_user = Factory.build(:user, :email => "new_foobar@mail.com", :password => "password", :password_confirmation => "drowssap")
        valid_user.should_not be_valid
      end

      it "should set the encrypted password" do
        @user.encrypted_password.should_not be_blank
      end
    end
  end
end