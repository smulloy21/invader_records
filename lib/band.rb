class Band < ActiveRecord::Base
  has_many :conquests
  has_many :venues, through: :conquests
  before_save(:capitalize_name)

private

  define_method(:capitalize_name) do
     self.name=(name().capitalize())
  end
end
