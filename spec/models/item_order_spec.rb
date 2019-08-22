require 'rails_helper'

describe ItemOrder do
  describe 'relationships' do
    it { should belong_to :order}
    it { should belong_to :item}
  end

  # validations ?
end
