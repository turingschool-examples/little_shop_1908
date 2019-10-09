class Merchant <ApplicationRecord
  has_many :items, dependent: :destroy

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

validates_length_of :zip, :is => 5
validates :zip, numericality: true
end
