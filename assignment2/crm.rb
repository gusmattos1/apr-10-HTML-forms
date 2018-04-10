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

get '/contacts/new' do
  @title = 'New contact'
  erb :new
end

get '/contacts/:id' do
  @contact = Contact.find_by({id: params[:id].to_i})
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get '/about' do
  @title = 'about'

  erb :about
end

post '/contacts' do
  Contact.create(
      first_name: params[:first_name],
      last_name:  params[:last_name],
      email:      params[:email],
      note:       params[:note]
    )
      redirect to '/contacts'
end

post '/contacts/search' do
@contacts = []
  Contact.all.each do |contact|
    if contact.inspect.include?(params[:search])
      @contacts.push contact
    end
  end

  erb :contacts

end
get '/contacts/:id/edit' do
  @contact = Contact.find_by(id: params[:id].to_i)
    if @contact
      erb :edit_contact
    else
      raise Sinatra::NotFound
    end
end

put '/contacts/:id' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    @contact.update(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:      params[:email],
    note:       params[:note]
    )

    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end

delete '/contacts/:id' do

  @contact = Contact.find(params[:id])
  if @contact
     @contact.delete
    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end



after do
  ActiveRecord::Base.connection.close
end
