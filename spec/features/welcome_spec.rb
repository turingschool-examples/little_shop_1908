require 'rails_helper'

RSpec.describe 'Main Page as WelcomeController' do
  it 'displays Item Index as main home page' do
    visit '/'

    expect(current_path).to eq('/items')
  end
end
