class CreateNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :message
      t.string :notification_type, null: false
      t.boolean :read, default: false
      t.json :data, default: {}
      t.references :scholarship, null: false, foreign_key: true
      t.datetime :sent_at

      t.timestamps
    end
  end
end
