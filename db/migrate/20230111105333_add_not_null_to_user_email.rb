# frozen_string_literal: true

class AddNotNullAndDefaultToUserEmail < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :email, false
  end
end
# t.string :email,              null: false, default: ""
