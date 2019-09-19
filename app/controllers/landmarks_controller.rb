class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
    @figures = Figure.all
    erb :"/landmarks/index"
  end

  get '/landmarks/new' do
    erb :"/landmarks/new"
  end

  post '/landmarks' do
    # binding.pry
    Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by(id: params[:id])

    erb :"/landmarks/show"
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by_id(params[:id])
    # binding.pry
    erb :"/landmarks/edit"
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params[:id])
    # binding.pry
    @landmark.update(params[:landmark])
    redirect :"/landmarks/#{@landmark.id}"
  end
end
