class CreateNotificationAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :notification_assignments do |t|
      t.integer :client_id
      t.integer :notification_id
      t.timestamp :seen_at

      t.timestamps
    end
  end
end
