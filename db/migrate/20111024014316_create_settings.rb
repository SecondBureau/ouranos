class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :site_name
      t.string :contact_email

      t.timestamps
    end
  end
end
