require './app/models/event.rb'
require './app/models/identity.rb'
require './app/models/response.rb'
require './app/models/user.rb'

class ChangeUsersToIdentities < ActiveRecord::Migration
  def change
    rename_table :users, :identities
    add_column :identities, :user_id, :integer

    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :avatar_url
      t.string :timezone

      t.boolean :profile_complete

      t.timestamps
    end

    Identity.all.each do |identity|
      identity.assign_user
      identity.save

      Response.where(user_id: identity.id).update_all(user_id: identity.user.id)
      Event.where(created_by: identity.id).update_all(created_by: identity.user.id)
    end
  end
end
