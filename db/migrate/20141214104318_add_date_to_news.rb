class AddDateToNews < ActiveRecord::Migration
  def change
    add_column :news, :created_at, :datetime
  end
end
