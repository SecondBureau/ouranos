class AddAttributesToPages < ActiveRecord::Migration
  def change
    add_column :pages, :locale, :string
    add_column :pages, :meta_keywords, :string
    add_column :pages, :meta_description, :string
  end
end
