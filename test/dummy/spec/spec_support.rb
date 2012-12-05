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