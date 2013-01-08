shared_examples_for 'admin role' do 
  it "can admin the store" do
    should be_able_to(:admin, :store)
  end
end

