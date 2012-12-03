require 'active_support/inflector'

shared_examples_for 'admin destroy' do |model, model_signature|
  let!(:existing_instance) {FactoryGirl.create(model)}

  it "deletes the #{model}" do
    expect{
      delete :destroy, id: existing_instance
    }.to change(model_signature, :count).by(-1)
  end

  it "marks it as deleted" do
    existing_instance.reload # to check that our updates are actually persisted
    expect{
      delete :destroy, id: existing_instance
    }.to change(model_signature.with_deleted, :count).by(0)
  end

  it "redirects to #{model.to_s.pluralize}#index" do
    delete :destroy, id: existing_instance
    response.should redirect_to send("admin_#{model.to_s.pluralize}_path".to_sym)
  end
end
