class RemoveImageAttributeFromSetting < ActiveRecord::Migration
  def up
    remove_column :settings, :banner_image_file_name
    remove_column :settings, :banner_image_content_type
    remove_column :settings, :banner_image_file_size
    remove_column :settings, :banner_image_updated_at
  end

  def down
    add_column :settings, :banner_image_file_name,    :string
    add_column :settings, :banner_image_content_type, :string
    add_column :settings, :banner_image_file_size,    :integer
    add_column :settings, :banner_image_updated_at,   :datetime
  end
end

