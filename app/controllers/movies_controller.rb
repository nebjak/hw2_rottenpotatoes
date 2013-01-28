class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = ['G','PG','PG-13','R']
    case params[:sort]
    when "title"
      @movies = Movie.order('title asc')
    when "release_date"
      @movies = Movie.order('release_date asc')
    else
      @movies = Movie.order()
    end
    unless params[:ratings].nil?
      @ratings = params[:ratings]
      rat = params[:ratings].map do |k, v|
        k
      end
      @movies = @movies.where :rating => rat
    else
      @ratings = Hash.new 0
      @movies = @movies.all
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
