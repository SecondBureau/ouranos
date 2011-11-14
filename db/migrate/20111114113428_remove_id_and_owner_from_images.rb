class RemoveIdAndOwnerFromImages < ActiveRecord::Migration
  def up
    remove_column :images , :image_owner_id
    remove_column :images , :image_owner_type
  end

  def down
    add_column :images , :image_owner_id , :integer
    add_column :images , :image_owner_type , :string
  end
end
