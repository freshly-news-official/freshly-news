class RemoveDateFromNews < ActiveRecord::Migration
  def change
    remove_column :news, :date, :datetime
  end
end
