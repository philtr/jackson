class SetDefaultValueForAdditionalGuestsOnResponses < ActiveRecord::Migration
  def change
    change_column :responses, :additional_guests, :integer, default: 0
  end
end
