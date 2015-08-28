require('spec_helper')

describe(Conquest) do
  it { should belong_to(:band) }
  it { should belong_to(:venue) }
end
