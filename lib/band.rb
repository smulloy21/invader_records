class Band < ActiveRecord::Base
  has_many :conquests
  has_many :venues, through: :conquests
  validates(:name, :presence => true)
  before_save(:capitalize_name)

private

  define_method(:capitalize_name) do
    arr = []
    name.split.each {|word| arr << word.capitalize}
    self.name=(arr.join(" "))
  end
end
