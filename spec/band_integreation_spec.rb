require('spec_helper')
require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)


describe('adding a new band', {:type => :feature}) do
  it('allows a user to add a band') do
    visit('/')
    fill_in('name', :with => 'Xerxes')
    click_button('add band')
    expect(page).to have_content('Xerxes')
  end
end

describe('updating a band', {:type => :feature}) do
  it('allows a user to update a band') do
    band = Band.create({:name => 'Alexander'})
    visit('/')
    click_link('Alexander')
    fill_in('new_name', :with => 'Alexander the Great')
    click_button('update')
    expect(page).to have_content('Alexander The Great')
  end
end

describe('deleting a band', {:type => :feature}) do
  it('allows a user to delete a band') do
    band = Band.create({:name => 'Hannibal'})
    visit('/')
    click_link('Hannibal')
    click_button('delete band')
    expect(page).to have_no_content('Hannibal')
  end
end

describe('adding a venue to a band', {:type => :feature}) do
  it('allows a user to add a venue to a band') do
    band = Band.create({:name => 'Genghis Khan'})
    visit('/')
    click_link('Genghis Khan')
    fill_in('venue_name', :with => 'Beijing')
    fill_in('new_date', :with => '1215')
    click_button('conquer!')
    expect(page).to have_content('Beijing')
  end
end

describe('canceling a show', {:type => :feature}) do
  it('allows a user to cancel (update) a show at a venue') do
    band = Band.create({:name => 'Richard the Lionhearted'})
    visit('/')
    click_link('Richard The Lionhearted')
    fill_in('venue_name', :with => 'Cyprus')
    fill_in('new_date', :with => '1191')
    click_button('conquer!')
    click_button('cancel')
    expect(page).to have_content('CANCELED')
  end
end
