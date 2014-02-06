class AddPromptedForDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :prompted_for_details, :boolean, default: false
  end
end
