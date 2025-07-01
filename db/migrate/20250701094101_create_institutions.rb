class CreateInstitutions < ActiveRecord::Migration[8.0]
  def change
    create_table :institutions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.string :country
      t.string :city
      t.string :website
      t.string :contact_email
      t.string :contact_phone
      t.string :logo_url

      t.timestamps
    end
  end
end
