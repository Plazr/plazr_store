RSpec::Matchers.define :be_nil_or_greater_than_or_equal_to do |minimum|
  match do |actual|
    result = actual == nil || minimum<actual || actual == minimum
    result
  end
end

RSpec::Matchers.define :be_greater_than_or_equal_to do |minimum|
  match do |actual|
    result = minimum<actual || actual == minimum
    result
  end
end

def build_attributes(factory_name)
  att = FactoryGirl.build(factory_name).attributes.delete_if do |k, v| 
    ["id", "created_at", "updated_at", "deleted_at"].member?(k)
  end
  Hash[att.map{|(k,v)| [k.to_sym,v]}]
end

#I also saw this one as an example, both work but the above is simpler
def params_for(factory_name)
  exclude_params = [ "id", "created_at", "updated_at", "deleted_at" ]
  f = FactoryGirl.build(factory_name)

  params = f.attributes.except(*exclude_params).dup

  f.reflections.select { |k,v|
    v.macro == :has_many && !v.instance_of?(ActiveRecord::Reflection::ThroughReflection)
  }.each_key do |k|
     assoc_collection = f.send(k)

    unless assoc_collection.empty?
      params["#{k.to_s}_attributes"] = {}

      assoc_collection.each_with_index do |assoc_obj,idx|
        params["#{k.to_s}_attributes"][idx.to_s] = assoc_obj.attributes.except(*exclude_params << "#{f.class.name.underscore}_id")
      end
    end
  end

  params
end