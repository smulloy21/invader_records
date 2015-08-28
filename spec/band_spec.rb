require('spec_helper')

describe(Band) do
  it { should have_many(:conquests) }
  it { should have_many(:venues).through(:conquests) }
end
