shared_examples_for 'assign and render' do |method|
  it "assigns the requested brand to @brand" do
    brand = FactoryGirl.create :brand
    get method, id: brand
    assigns(:brand).should eq(brand)
  end

  it "renders the :#{method} template" do
    get method, id: FactoryGirl.create(:brand)
    response.should render_template method
  end
end
