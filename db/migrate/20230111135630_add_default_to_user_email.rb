# frozen_string_literal: true

class AddDefaultToUserEmail < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :email, ''
  end
end
