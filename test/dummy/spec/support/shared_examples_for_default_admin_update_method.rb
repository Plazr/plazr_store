require 'active_support/inflector'

#3 args: model is the model to be tested, att_valid is an array of the attributes to be validated
#and the att_invalid is just one attribute to test the invalid operation
shared_examples_for 'default admin update method' do |model, att_valid, att_invalid|
    let(:existing_instance) {FactoryGirl.create(model)}

    context "valid attributes" do
      let(:new_instance) { FactoryGirl.attributes_for("#{model}_v2".to_sym)}

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

    context "invalid attributes" do
      it "locates the requested #{model}" do
        put :update, id: existing_instance, model => FactoryGirl.attributes_for("invalid_#{model}".to_sym)
        assigns(model).should eq(existing_instance)      
      end

      it "does not change #{model}'s #{att_invalid}" do
        old_var = existing_instance.send(att_invalid)
        put :update, id: existing_instance, model => FactoryGirl.attributes_for("invalid_#{model}".to_sym)
        existing_instance.reload # to check that our updates are actually persisted
        existing_instance.send(att_invalid).should eq(old_var)
      end
      
      it "re-renders the edit method" do
        put :update, id: existing_instance, model => FactoryGirl.attributes_for("invalid_#{model}".to_sym)
        response.should render_template :edit
      end
    end
end
