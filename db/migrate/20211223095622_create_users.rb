class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: true ,index: { unique: true, name: 'unique_emails' }
      t.string :password
      t.string :remember_token, null: true
      t.integer :role, null: true
      t.string :phone, null: true

      t.timestamps
    end
  end
end
