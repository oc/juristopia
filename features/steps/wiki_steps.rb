Before do
  CouchRest.delete(DB)
  CouchRest.database!(DB)
end

Given /^the following pages:$/ do |table|
  table.hashes.each do |params|
    Page.create!(params)
  end
end


When /^I visit (.*)$/ do |page|
  visits page
end

Then /^I should see the following:$/ do |table|
  table.raw.each do |row|
    response_body.should =~ /#{row[0]}/
  end
end


