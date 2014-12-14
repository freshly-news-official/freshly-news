class ChangedSiteIdToWebsiteId < ActiveRecord::Migration
  def change
    rename_column :categories, :site_id, :website_id
  end
end
