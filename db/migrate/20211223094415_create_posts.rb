class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description, null: true
      t.integer :public_flag
      t.integer :created_by, null: true
      t.integer :updated_by, null: true

      t.timestamps
    end
  end
end
