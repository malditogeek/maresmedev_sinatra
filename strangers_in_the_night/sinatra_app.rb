require 'rubygems'
require 'bundler/setup'
require 'sinatra/base'
require 'ohm'

module SongApp

  class Song < Ohm::Model
    attribute :name
  end

  class Application < Sinatra::Base

    configure do
      Ohm.connect
    end

    before do
      @songs_count = Song.all.size
    end

    after do
    end
   
    helpers do
      def debug
        p [:request, request]
        p [:params, params]
      end
      def find_all_songs
         @songs = Song.all
      end
    end

    get '/' do
      redirect '/songs', 301
    end

    get '/songs' do
      find_all_songs

      erb :songs
    end

    # curl -i -X POST "http://localhost:9393/songs" -d "name=My Way"
    post '/songs' do
      Song.create(:name => params[:name])

      redirect '/songs'
    end

    # curl -i -X GET "http://localhost:9393/songs/N"
    get '/songs/:id' do |id|
      debug
      @song = Song[id]

      erb :song
    end

    # curl -i -X PUT "http://localhost:9393/songs/N" -d "name=My Way"
    put '/songs/:id' do |id|
      song = Song[id]
      song.name = new_name
      song.save

      redirect '/songs'
    end

    # curl -i -X DELETE "http://localhost:9393/song/N"
    delete '/songs/:id' do |id|
      song = Song[id]
      song.delete if song

      #redirect '/songs'
      200
    end

  end
end
