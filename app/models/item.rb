# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id             :bigint           not null, primary key
#  active         :boolean
#  borrowed       :boolean
#  borrowed_at    :datetime
#  item_type      :integer          default("other"), not null
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  borrowed_to_id :integer
#  user_id        :integer
#
# Indexes
#
#  index_items_on_name  (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Item < ApplicationRecord
  enum item_type: { book: 0, cd: 1, electric_device: 2, flower: 3, other: 4, bizuteria: 5, odziez: 6 }
  validates :item_type, inclusion: { in: item_types.keys }
  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :borrowed, -> { where(borrowed: true) }
  scope :on_place, -> { where(borrowed: false) }

  belongs_to :user, optional: true
  belongs_to :borrowed_to, class_name: 'User', optional: true, foreign_key: 'borrowed_to_id'
  has_many :rental_requests, dependent: :destroy


  def requested_by?(requesting_user)
    rental_requests.where(user_id: requesting_user.id).exists?
  end

  def requested?
    rental_requests.exists?
  end
end
