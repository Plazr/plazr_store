shared_examples_for 'default admin new method' do |model, model_signature|
  it "assigns a new #{model} to @#{model}" do
    get :new
    assigns(model).should be_an_instance_of model_signature
  end
  it "renders the :new template" do
    get :new
    response.should render_template :new
  end
end
