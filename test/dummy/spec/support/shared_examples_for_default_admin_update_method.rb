require 'active_support/inflector'

#2 args: model is the model to be tested, att_valid is an array of the attributes to be validated
shared_examples_for 'default admin update method' do |model, att_valid|
  let(:existing_instance) {FactoryGirl.create(model)}

  context "valid attributes" do
    let(:new_instance) { build_attributes("#{model}_v2".to_sym)}

    it "locates the requested #{model}" do
      put :update, id: existing_instance, model => new_instance
      assigns(model).should eq(existing_instance)      
    end

    att_valid.each do |var|
      it "changes #{model}'s #{var}" do
        put :update, id: existing_instance, model => new_instance
        existing_instance.reload # to check that our updates are actually persisted
        existing_instance.send(var).should eq(new_instance[var])
      end
    end

    it "redirects to the updated #{model}" do
      put :update, id: existing_instance, model => new_instance
      response.should redirect_to send("admin_#{model}_url".to_sym, existing_instance)
    end
  end

  #if the time comes that we need to test invalid attributes with a foreign key, 
  # we should switch 'FactoryGirl.attributes_for' by 'build_attributes'
  context "invalid attributes" do
    it "locates the requested #{model}" do
      put :update, id: existing_instance, model => FactoryGirl.attributes_for("invalid_#{model}".to_sym)
      assigns(model).should eq(existing_instance)      
    end

    att_valid.each do |var|
      it "does not change #{model}'s #{var}" do
        old_var = existing_instance.send(var)
        put :update, id: existing_instance, model => FactoryGirl.attributes_for("invalid_#{model}".to_sym)
        existing_instance.reload # to check that our updates are actually persisted
        existing_instance.send(var).should eq(old_var)
      end
    end

    it "re-renders the edit method" do
      put :update, id: existing_instance, model => FactoryGirl.attributes_for("invalid_#{model}".to_sym)
      response.should render_template :edit
    end
  end
end
