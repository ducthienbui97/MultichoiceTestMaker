class AddPointToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :point, :integer, default: 0
  end
end
