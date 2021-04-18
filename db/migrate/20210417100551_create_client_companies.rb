class CreateClientCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :client_companies do |t|
      t.float :weight, default: 0.025
      t.integer :client_id
      t.integer :company_id
      t.index [:client_id, :company_id], unique: true

      t.timestamps
    end
  end
end
