class Conquest < ActiveRecord::Base
  belongs_to :band
  belongs_to :venue
  validates(:band_id, :presence => true)
  validates(:venue_id, :presence => true)
  scope(:not_canceled, -> do
    where({:canceled => false})
  end)
  before_save(:capitalize_date)

  define_singleton_method(:find_by_band_and_venue) do |band_id, venue_id|
    Conquest.all.each do |conquest|
      if conquest.band_id == band_id && conquest.venue_id == venue_id
        return conquest
      end
    end
  end

  define_singleton_method(:any_not_canceled) do |band|
    any = []
    band.conquests.each do |conquest|
      if conquest.not_canceled
        any << conquest
      end
    end
    any
  end

private

  define_method(:capitalize_date) do
    arr = []
    date.split.each do |word|
      if word.downcase == "bc" || word.downcase == "ad"
        arr << word.upcase
      else
        arr << word.capitalize
      end
    end
    self.date=(arr.join(" "))
  end
end
