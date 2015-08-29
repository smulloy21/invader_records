require('rspec')
require('pg')
require('sinatra/activerecord')
require('product')
require('order')
require('customer')
require('cart')

require('capybara/rspec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('./app')

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.color = true
  config.after(:each) do
    Band.all().each() do |band|
      band.destroy()
    end
    Venue.all().each() do |venue|
      venue.destroy()
    end
    Conquest.all().each() do |conquest|
      conquest.destroy()
    end
  end
end
