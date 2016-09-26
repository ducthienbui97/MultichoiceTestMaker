class AddPublicToTests < ActiveRecord::Migration
  def change
    add_column :tests, :public, :boolean
    add_column :tests, :done, :boolean
  end
end
