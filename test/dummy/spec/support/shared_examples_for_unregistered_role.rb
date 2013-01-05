shared_examples_for 'unregistered role' do 
  it "can exhibit products and show a specific product" do
    should be_able_to(:read, PZS::Product.new)
  end
  it "can exhibit pages and show a specific page" do
    should be_able_to(:read, PZS::Page.new)
  end
end

