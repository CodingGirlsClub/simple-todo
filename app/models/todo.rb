class Todo < ApplicationRecord
  scope :ordered, -> { order("is_finished, created_at desc") }
  belongs_to :user
end
