shared_examples_for 'default admin create method' do |model, model_signature|
  context "with valid attributes" do
    it "saves the new #{model} in the database" do
      expect{
        post :create, model => FactoryGirl.attributes_for(model)
      }.to change(model_signature, :count).by(1)
    end
    it "redirects to the :show template" do
      post :create, model => FactoryGirl.attributes_for(model)
      response.should redirect_to send("admin_#{model}_url".to_sym, model_signature.send(:last))
    end
  end

  context "with invalid attributes" do
    it "does not save the new #{model} in the database" do
      expect{
        post :create, model => FactoryGirl.attributes_for("invalid_#{model}".to_sym)
      }.to_not change(model_signature, :count)
    end
    it "re-renders the :new template" do
      post :create, model => FactoryGirl.attributes_for("invalid_#{model}".to_sym)
      response.should render_template :new
    end
  end
end
