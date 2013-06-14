class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references    :user
      t.string        :event_id
      t.string        :organization

      t.integer       :additional_guests
      t.text          :comments

      t.timestamps
    end
  end
end
