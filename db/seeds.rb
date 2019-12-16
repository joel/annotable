require 'ffaker'
require 'fabrication'

require_dependency Rails.root.join('../../spec/support/helpers.rb')

Fabrication.configure { |config| config.path_prefix = File.expand_path('..', __dir__) }

5.times.each do
  organization = Fabricate(:organization)
  puts("Create Organization #{organization.name} [#{organization.id}]")
  10.times.each do
    user = Fabricate(:user, organization: organization)
    puts("Create User #{user.name} <#{user.email}>")
  end
  10.times.each do
    report = Fabricate.create(:report, organization: organization)
    puts("Create Report #{report.name}")
  end
end
