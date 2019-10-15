class Customer
  attr_reader :name, :address, :city, :state, :zip

  def initialize(customer_info)
    @name = customer_info["name"]
    @address = customer_info["address"]
    @city = customer_info["city"]
    @state = customer_info["state"]
    @zip = customer_info["zip"]
  end
end
