class RemoveColumnFromReviews < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :review, :string
  end
end
