class SetDefaultLocaleToBeFrOfPost < ActiveRecord::Migration
  def up
    change_column :posts, :locale, :string, :default => "fr"
  end

  def down
    change_column :posts, :locale, :string
  end
end
