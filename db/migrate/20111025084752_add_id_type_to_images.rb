class AddIdTypeToImages < ActiveRecord::Migration
  def change
    add_column :images , :image_owner_id , :integer
    add_column :images , :image_owner_type , :string
  end
end
