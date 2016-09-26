class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :question, index: true, foreign_key: true
      t.text :description, null: false
      t.boolean :correct, null: false, default: false
      t.timestamps null: false
    end
  end
end
