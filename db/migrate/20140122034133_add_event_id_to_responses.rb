class AddEventIdToResponses < ActiveRecord::Migration
  def change
    remove_column :responses, :event_id
    add_reference :responses, :event, index: true
  end
end
