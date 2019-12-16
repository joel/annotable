class CreateAnnotableReports < ActiveRecord::Migration[6.0]
  def change
    create_table :annotable_reports, id: :uuid do |t|
      t.string :name
      t.text :content
      t.references :organization, null: false, type: :uuid
      t.timestamps
    end

    add_foreign_key :annotable_reports, :annotable_organizations, column: :organization_id
  end
end
