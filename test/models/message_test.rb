# == Schema Information
#
# Table name: messages
#
#  id            :bigint           not null, primary key
#  body          :text
#  read_at       :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  receipient_id :integer          not null
#  sender_id     :integer          not null
#
# Indexes
#
#  index_messages_on_receipient_id  (receipient_id)
#  index_messages_on_sender_id      (sender_id)
#
require "test_helper"

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
