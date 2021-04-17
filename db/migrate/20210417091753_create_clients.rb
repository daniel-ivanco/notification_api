class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.uuid :uuid, default: 'gen_random_uuid()'
      t.string :name
      t.float :portfolio_performance
      t.timestamp :portfolio_calculated_at
      t.index :uuid, unique: true

      t.timestamps
    end
  end
end
