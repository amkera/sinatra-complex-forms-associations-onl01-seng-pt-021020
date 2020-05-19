class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
    #render the index page
  end

  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'
    #render the page to create an owner
  end

  post '/owners' do
    @owner = Owner.create(params[:owner])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "/owners/#{@owner.id}"
    #actually creates the owner
  end

  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
    #get the form to allow an user to update an owner
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end
  #finds the owner by their id 

  patch '/owners/:id' do
    @owner = Owner.find(params[:id])
    @owner.update(params[:owner])

    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end

    redirect "/owners/#{@owner.id}"
  end
  #actually processes the edit request
end