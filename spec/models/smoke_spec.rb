require 'rails_helper'

class Dawg < Struct.new(:name)
end

RSpec.describe(Dawg, type: :model) do
  it 'has a name' do
    earl = Dawg.new('Earl')

    expect(earl.name).to(eq('Earl'))
  end
end
