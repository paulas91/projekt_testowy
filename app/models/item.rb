# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id         :bigint           not null, primary key
#  active     :boolean
#  borrowed   :boolean
#  item_type  :integer          default("other"), not null
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Item < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }

  enum item_type: { book: 0, cd: 1, electric_device: 2, flower: 3, other: 4, bizuteria: 5, odziez: 6 }

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :borrowed, -> { where(borrowed: true) }
  scope :on_place, -> { where(borrowed: false) }
end
