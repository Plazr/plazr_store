shared_examples_for 'staff role' do 
  it "can manage the store" do
    should be_able_to(:manage, :store)
  end
end

