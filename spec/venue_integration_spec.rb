require('spec_helper')


describe('updating a venue', {:type => :feature}) do
  it('allows a user to update a venue') do
    band = Band.create({:name => 'Napoleon'})
    venue = Venue.create({:name => 'Russia'})
    conquest = Conquest.create({:band_id => band.id, :venue_id => venue.id, :date => '1812', :canceled => false})
    visit('/')
    click_link('Napoleon')
    click_link('Russia')
    fill_in('new_name', :with => 'Moscow')
    click_button('update')
    expect(page).to have_content('Moscow')
  end
end

describe('deleting a venue', {:type => :feature}) do
  it('allows a user to delete a venue') do
    band = Band.create({:name => 'Charlemagne'})
    venue = Venue.create({:name => 'Italy'})
    conquest = Conquest.create({:band_id => band.id, :venue_id => venue.id, :date => '769', :canceled => false})
    visit('/')
    click_link('Charlemagne')
    click_link('Italy')
    click_button('delete venue')
    expect(page).to have_no_content('Italy')
  end
end
