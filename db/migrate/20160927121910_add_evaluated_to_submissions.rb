class AddEvaluatedToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :evaluated, :boolean
  end
end
