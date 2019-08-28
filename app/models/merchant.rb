class Merchant < ApplicationRecord
  has_many :items

  validates_presence_of :name,
                        :address,
                        :city,
                        :state
  validates :zip, numericality: {only_integer: true}

  def has_items_ordered
    ids = Item.joins(:item_orders).pluck(:merchant_id)
    ids.include?(self.id)
  end

  def item_count
    items.count
  end

  def average_item_price
    items.average(:price)
  end

  def cities_serviced
    Item.joins(:orders)
    .where(merchant_id: self.id)
    .distinct
    .pluck(:city)
  end

  def top_three_item_ids
    top_ids = ActiveRecord::Base.connection.execute("select item_id from (select items.id as item_id, items.merchant_id, items.name, avg(reviews.rating) from items inner join reviews on items.id = reviews.item_id where items.merchant_id = #{self.id} group by items.id order by avg desc limit 3) as item_id")
    ids = top_ids.values.flatten
    ids
    # top = items.sort_by{|item| item.avg_rating}.reverse
    # top.slice(0..2)
  end
end
