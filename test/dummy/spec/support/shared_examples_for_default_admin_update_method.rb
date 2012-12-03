require 'active_support/inflector'

shared_examples_for 'admin update' do |model, attribute|
    let(:existing_instance) {FactoryGirl.create(model)}

    context "valid attributes" do
      let(:new_instance) { FactoryGirl.attributes_for("#{model}_v2".to_sym)}

      it "locates the requested #{model}" do
        put :update, id: existing_instance, model => new_instance
        assigns(model).should eq(existing_instance)      
      end

      it "changes #{model}'s attributes" do
        put :update, id: existing_instance, model => new_instance
        existing_instance.reload # to check that our updates are actually persisted
        existing_instance.send(attribute).should eq(new_instance[attribute])
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

      it "does not change #{model}'s attributes" do
        put :update, id: existing_instance, model => FactoryGirl.attributes_for("invalid_#{model}".to_sym)
        existing_instance.reload # to check that our updates are actually persisted
        existing_instance.send(attribute).should_not be_nil
      end

      it "re-renders the edit method" do
        put :update, id: existing_instance, model => FactoryGirl.attributes_for("invalid_#{model}".to_sym)
        response.should render_template :edit
      end
    end
end
