module Annotable
  Fabricator(:report, from: Report) do
    name { FFaker::Product.product_name }
    content { FFaker::Lorem.paragraph }
    organization
  end
end
