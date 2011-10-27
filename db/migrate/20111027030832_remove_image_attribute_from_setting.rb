class RemoveImageAttributeFromSetting < ActiveRecord::Migration
  def change
    remove_column :settings, :banner_image_file_name
    remove_column :settings, :banner_image_content_type
    remove_column :settings, :banner_image_file_size
    remove_column :settings, :banner_image_updated_at
  end
end
