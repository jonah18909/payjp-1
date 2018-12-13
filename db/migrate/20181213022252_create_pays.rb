class CreatePays < ActiveRecord::Migration[5.0]
  def change
    create_table :pays do |t|
      t.string :customer, unieque: true
      t.integer :user_id, index: true

      t.timestamps
    end
  end
end
