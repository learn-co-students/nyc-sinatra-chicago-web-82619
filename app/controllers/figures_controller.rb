class FiguresController < ApplicationController
  # add controller methods
  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"/figures/new"
  end

  post '/figures/?' do
    @figure = Figure.create(params['figure'])
     unless params[:landmark][:name].empty?
       # binding.pry
       @figure.landmarks << Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year])
     end

     unless params[:title][:name].empty?
       @figure.titles << Title.create(params[:title])
     end

     @figure.save
   redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    erb :"/figures/show"
  end

  get '/figures' do
    @figures = Figure.all
    # binding.pry
    erb :"/figures/index"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by(id: params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"/figures/edit"
  end

  patch '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.update(params[:figure])
    @figure.titles.clear
    @figure.landmarks.clear
    unless params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end
    unless params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end
    @figure.save

    redirect :"/figures/#{@figure.id}"
  end
end

{"figure"=>{"name"=>"avinash", "title_ids"=>["2"], "landmark_ids"=>["4"]},
 "title"=>{"name"=>"the don again"},
 "landmark"=>{"name"=>"pyramid house", "year"=>"1911"},
 "submit"=>"Create New Figure"}
