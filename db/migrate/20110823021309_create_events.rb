class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, :null => false
      t.text :content, :null => false
      t.date :start_date, :null => false
      t.date :end_date

      t.timestamps
    end
  end
end
