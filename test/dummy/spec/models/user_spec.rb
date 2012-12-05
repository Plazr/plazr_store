require 'spec_helper'

PZA=PlazrAuth

describe PZA::User, type: :model do

  context 'users database should be cleaned between tests' do
    it 'should create a user wihout complaining about email existing' do
      FactoryGirl.create(:specific_user).should be_valid
    end

    it 'should create a user wihout complaining about email existing' do
      FactoryGirl.create(:specific_user).should be_valid
    end
  end

end
