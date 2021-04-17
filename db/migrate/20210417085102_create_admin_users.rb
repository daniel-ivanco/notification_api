class CreateAdminUsers < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :admin_users do |t|
      t.uuid :uuid, default: 'gen_random_uuid()'
      t.string :first_name
      t.string :last_name
      t.index :uuid, unique: true

      t.timestamps
    end
  end
end
