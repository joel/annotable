module Annotable
  Fabricator(:organization, from: Organization) do
    name { FFaker::Company.name }
  end
end
