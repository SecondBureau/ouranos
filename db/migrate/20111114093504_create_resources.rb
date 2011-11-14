class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :title
      t.string :resource_file_name
      t.string :resource_content_type
      t.integer :resource_file_size

      t.timestamps
    end
  end
end
