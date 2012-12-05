require 'active_support/inflector'

shared_examples_for 'before filter and assign' do |method, model, variables_to_assign|
  variables_to_assign.each do |var|
    it "assigns all #{var.to_s.pluralize} to @#{var.to_s.pluralize}" do
      v = FactoryGirl.create var
      m = FactoryGirl.create model
      if method == :edit
        get :edit, id: m
      elsif method == :new
        get :new
      end
      assigns(var.to_s.pluralize.to_sym).should eq([v])
    end
  end
end
