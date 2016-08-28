class Todo < ApplicationRecord
  # scope排序方法
  scope :ordered, -> { order("is_finished, created_at desc") }

  # 每个todo都归属于一个user
  belongs_to :user
end
