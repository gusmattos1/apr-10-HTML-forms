require 'sinatra'
require_relative 'contact'

get '/' do
  redirect to ('/home')
end

get '/home' do
  @title = 'Home'
  erb :index
end


get '/contacts' do
  @title = 'Contacts'
  @contacts = Contact.all
  erb :contacts
end

get '/contacts/:id' do
  @contact = Contact.find_by({id: params[:id].to_i})
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get '/new' do
  erb :new
end

get '/about' do
  @title = 'about'

  erb :about
end

after do
  ActiveRecord::Base.connection.close
end
