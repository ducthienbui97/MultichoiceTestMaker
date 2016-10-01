class AddPointToTests < ActiveRecord::Migration
  def change
    add_column :tests, :point, :integer, default: 0
  end
end
