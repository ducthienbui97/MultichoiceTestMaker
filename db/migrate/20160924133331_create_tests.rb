class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.references :User, index: true, foreign_key: true
      t.string :title, null: false, unique: true
      t.text :description, null: false, default: ""
      t.integer :length, null:false
      t.timestamps null: false
    end
  end
end
