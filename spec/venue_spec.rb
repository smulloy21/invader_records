require('spec_helper')

describe(Venue) do
  it { should have_many(:conquests) }
  it { should have_many(:bands).through(:conquests) }
end
