class CreateScholarships < ActiveRecord::Migration[8.0]
  def change
    create_table :scholarships do |t|
      t.references :institution, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.text :requirements
      t.text :benefits
      t.string :level
      t.string :field_of_study
      t.string :country
      t.string :city
      t.decimal :pourcentage, precision: 5, scale: 2
      t.string :scholarship_type
      t.integer :duration_months
      t.date :application_deadline
      t.date :program_start_date
      t.string :language
      t.integer :age_min
      t.integer :age_max
      t.string :gender_requirement
      t.string :external_application_url
      t.boolean :active, default: true

      t.timestamps
    end

  end
end
