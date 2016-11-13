class AddTokenToTests < ActiveRecord::Migration
  def change
    add_column :tests, :token, :string, index: true
  end
end
