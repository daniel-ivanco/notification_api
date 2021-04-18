class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.uuid :uuid, default: 'gen_random_uuid()'
      t.text :title
      t.text :desc
      t.boolean :active, default: true
      t.index :uuid, unique: true

      t.timestamps
    end
  end
end
