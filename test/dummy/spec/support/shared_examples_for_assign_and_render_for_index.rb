require 'active_support/inflector'

shared_examples_for 'assign and render for index' do |model|
  it "assigns #{model.to_s.pluralize}" do
    m = FactoryGirl.create model
    get :index
    assigns(model.to_s.pluralize.to_sym).should eq([m])
  end

  it "renders the :index template" do
    get :index
    response.should render_template :index
  end
end
