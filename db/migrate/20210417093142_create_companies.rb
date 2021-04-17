class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.float :monthly_twr
      t.timestamp :twr_calculated_at
      t.index :name, unique: true

      t.timestamps
    end
  end
end
