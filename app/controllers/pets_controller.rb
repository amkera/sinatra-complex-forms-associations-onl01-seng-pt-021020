class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end
  #shows the pets index page

  get '/pets/new' do
    erb :'/pets/new'
  end
  #shows the page to create a new pet 

  post '/pets' do
    @pet = Pet.create(params[:pet])

    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    #if the owner's name in the params hash is not empty, create a pet and associate it to its owner

    @pet.save
    #save to db 

    redirect to "pets/#{@pet.id}"
    #redirect the user to the pet they just created. 
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  #take user to the pets show page, where an edit link should be

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end
  #show the page that an owner can edit the pet 

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    #using active record methods 

    #binding.pry

    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    #"recreates" the pet-owner association

    @pet.save
    #saves it to db

    redirect to "pets/#{@pet.id}"
  end
  #actually process the edit request
end