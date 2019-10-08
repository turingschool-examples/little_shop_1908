class AddReviewsToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :review, foreign_key: true
  end
end
