class AddAttributesToEvents < ActiveRecord::Migration
  def change
    add_column :events, :locale, :string
    add_column :events, :meta_keywords, :string
    add_column :events, :meta_description, :string
    add_column :events, :permalink, :string
  end
end
