class CreateAnnotableUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :annotable_users, id: :uuid do |t|
      t.string :name
      t.string :email
      t.references :organization, null: true, type: :uuid

      t.timestamps
    end
    add_foreign_key :annotable_users, :annotable_organizations, column: :organization_id
  end
end
