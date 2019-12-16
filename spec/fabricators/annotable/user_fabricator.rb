module Annotable
  Fabricator(:user, from: User) do
    name  { user_attributes[:name]  }
    email { user_attributes[:email] }
    organization
  end
end
