class SongsController < ApplicationController

  require 'rack-flash'
  use Rack::Flash
  enable :sessions

  get '/songs' do
    @songs = Song.all

    erb :"songs/index"
  end

  get '/songs/new' do
    @artists = Artist.all
    @genres = Genre.all

    erb :"songs/new"
  end

  get "/songs/:slug" do
    @song = Song.find_by_slug(params["slug"])

    erb :"songs/show"
  end

  post '/songs' do
    #binding.pry
    @song = Song.create(params[:song])

    if !params[:genre][:name].empty?
      @song.genres << Genre.create(params[:genre])
    end

    if !params[:artist][:name].empty?
      @song.artist = Artist.create(params[:artist])
    end
  #  binding.pry


    @song.save
    flash[:message] = "Successfully created song."


    redirect "/songs/#{@song.slug}"
  end

  get "/songs/:slug/edit" do
    @song = Song.find_by_slug(params["slug"])
    @artists = Artist.all
    @genres = Genre.all

    erb :"songs/edit"
  end






end
