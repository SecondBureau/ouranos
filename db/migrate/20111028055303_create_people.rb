class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.datetime :birthdate
      t.string :fa_type
      t.belongs_to :family

      t.timestamps
    end
    add_index :people, :family_id
  end
end
