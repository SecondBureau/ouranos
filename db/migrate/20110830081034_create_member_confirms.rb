class CreateMemberConfirms < ActiveRecord::Migration
  def change
    create_table :member_confirms do |t|
      t.belongs_to :user
      t.date :send_date

      t.timestamps
    end
    add_index :member_confirms, :user_id
  end
end
