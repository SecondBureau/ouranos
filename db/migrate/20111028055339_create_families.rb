class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :name
      t.belongs_to :user

      t.timestamps
    end
    add_index :families, :user_id
  end
end
