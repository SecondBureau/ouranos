class ChangeNewsletterColumnName < ActiveRecord::Migration
  def up
    rename_column :users, :newsletter, :opt_in_newsletter
  end

  def down
  end
end
