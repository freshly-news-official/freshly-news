class AddTagImageToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :tag_image, :string
  end
end
