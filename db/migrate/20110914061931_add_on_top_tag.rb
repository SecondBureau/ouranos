class AddOnTopTag < ActiveRecord::Migration
  def change
    add_column :pages, :is_on_top, :boolean
  end
end
