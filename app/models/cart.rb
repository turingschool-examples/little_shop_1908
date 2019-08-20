class Cart < ApplicationController
  attr_reader :items

  def initialize
    @items = []
  end

  def total
    @items.count
  end

end
