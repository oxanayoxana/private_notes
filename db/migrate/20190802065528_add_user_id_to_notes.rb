# frozen_string_literal: true

class AddUserIdToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :user_id, :integer
  end
end
