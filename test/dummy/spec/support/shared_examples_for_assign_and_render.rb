shared_examples_for 'assign and render' do |method, model|
  it "assigns the requested #{model} to @#{model}" do
    m = FactoryGirl.create model
    get method, id: m
    assigns(model).should eq(m)
  end

  it "renders the :#{method} template" do
    get method, id: FactoryGirl.create(model)
    response.should render_template method
  end
end