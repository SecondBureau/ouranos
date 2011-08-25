class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :content
      t.date :start_date
      t.date :end_date
      t.integer :priority

      t.timestamps
    end
  end
end
