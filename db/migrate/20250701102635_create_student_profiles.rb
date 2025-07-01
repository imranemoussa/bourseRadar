class CreateStudentProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :student_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.date :birth_date
      t.string :nationality
      t.string :current_level
      t.string :current_institution
      t.string :field_of_study
      t.text :bio
      t.string :address
      t.string :city
      t.string :country

      t.timestamps
    end
      add_index :student_profiles, :nationality
      add_index :student_profiles, :current_level
      add_index :student_profiles, :field_of_study
      add_index :student_profiles, :country
  end
end
