class AddColumnToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :content, :string
  end
end
