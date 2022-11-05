# == Schema Information
#
# Table name: items
#
#  id         :bigint           not null, primary key
#  active     :boolean
#  borrowed   :boolean
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Item < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: {minimum:3, maximum:25}
end
