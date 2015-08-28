ENV['RACK_ENV'] = 'development'
# ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
require('bundler/setup')
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @bands = Band.all
  erb(:index)
end

post('/bands/new') do
  Band.create({:name => params.fetch('name'), :tagline => params.fetch('tagline')})
  redirect('/')
end

delete('/clear') do
  Band.all.each {|t| t.destroy()}
  Venue.all.each {|t| t.destroy()}
  Conquest.all.each {|t| t.destroy()}
  redirect('/')
end

#############################     band page     ###########################

get('/bands/:id') do
  @band = Band.find(params.fetch('id').to_i)
  @conquests = @band.conquests
  @venues = Venue.all - @band.venues
  @conquests_not_canceled = @band.conquests.not_canceled
  erb(:band)
end

post('/bands/:id/add_venue') do
  @band = Band.find(params.fetch('id').to_i)
  if params.fetch('venue')
    Conquest.create({:band_id => @band.id, :venue_id => params.fetch('venue'), :date => params.fetch('add_date'), :canceled => false})
  end
  redirect('/bands/' + @band.id.to_s)
end

post('/venues/new') do
  @band = Band.find(params.fetch('band_id').to_i)
  venue = Venue.create({:name => params.fetch('venue_name')})
  Conquest.create({:band_id => @band.id, :venue_id => venue.id, :date => params.fetch('new_date'),  :canceled => false})
  redirect('/bands/' + @band.id.to_s)
end

patch('/bands/:id/cancel_show') do
  @band = Band.find(params.fetch('id').to_i)
  conquests = Conquest.find_by_band_and_venue(@band.id, params.fetch('venue_delete'))
  conquests.each { |conquest| Conquest.update(conquest.id, {:canceled => true}) }
  redirect('/bands/' + @band.id.to_s)
end

patch('/bands/:id/edit') do
  @band = Band.find(params.fetch('id').to_i)
  if params.fetch('new_name') != ""
    @band.update({:name => params.fetch('new_name')})
  end
  if params.fetch('new_tagline') != ""
    @band.update({:tagline => params.fetch('new_tagline')})
  end
  redirect('/bands/' + @band.id.to_s)
end

delete('/bands/:id/delete') do
  @band = Band.find(params.fetch('id').to_i)
  @band.conquests.each { |conquest| conquest.destroy }
  @band.destroy()
  redirect('/')
end

#############################     venue page     ###########################

get('/venues/:id') do
  @venue = Venue.find(params.fetch('id').to_i)
  @conquests = @venue.conquests
  erb(:venue)
end

patch('/venues/:id/edit') do
  @venue = Venue.find(params.fetch('id').to_i)
  if params.fetch('new_name') != ""
    @venue.update({:name => params.fetch('new_name')})
  end
  redirect('/venues/' + @venue.id.to_s)
end

delete('/venues/:id/delete') do
  @venue = Venue.find(params.fetch('id').to_i)
  @venue.conquests.each { |conquest| conquest.destroy }
  @venue.destroy()
  redirect('/')
end
