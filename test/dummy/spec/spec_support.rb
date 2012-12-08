#this is an rspec test to see if the field to be tested is greater or equal to a given number or if it is nil
RSpec::Matchers.define :be_nil_or_greater_than_or_equal_to do |minimum|
  match do |actual|
    result = actual == nil || minimum<actual || actual == minimum
    result
  end
end

#this is an rspec test to see if the field to be tested is greater or equal to a given number
RSpec::Matchers.define :be_greater_than_or_equal_to do |minimum|
  match do |actual|
    result = minimum<actual || actual == minimum
    result
  end
end

def build_attributes(factory_name)
  #this gets all the attributes of a given factory including associations and strips the fields 'id', 'created_at', 'updated_at' and 'deleted_at'
  #because they cant be mass-assigned and returns an array
  att = FactoryGirl.build(factory_name).attributes.delete_if do |k, v| 
    ["id", "created_at", "updated_at", "deleted_at"].member?(k)
  end
  #here we take the array and symbolize the keys
  Hash[att.map{|(k,v)| [k.to_sym,v]}]
end
