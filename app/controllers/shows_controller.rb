class ShowsController < ApplicationController
  # Show all movies in the drop-down
  def index
    @movie = Movie.find_by(id: params[:movie_id])  # Safely finding the movie by ID
    @shows = @movie.shows
  end

  def new
    @show = Show.new
    @movies = Movie.all  # Fetch all movies
    @selected_movie = Movie.find_by(id: params[:movie_id]) 
  end

  def edit 
    @show = Show.find(params[:id])
    @movies = Movie.all
  end

  def update
    @show = Show.find(params[:id])
    respond_to do |format|
      if @show.update(show_params)
        format.html { redirect_to @show, notice: "Show was successfully updated." }
        format.json { render :show, status: :ok, location: @show }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  # Create a new show and associate it with the selected movie
  def create
    @show = Show.new(show_params)
    @movie = Movie.find_by(id: params[:show][:movie_id])  # Find the movie by ID
    
    if @movie
      @show.movie = @movie  # Associate the show with the selected movie
      respond_to do |format|
        if @show.save
          format.html { redirect_to @show, notice: "Show was successfully created." }
          format.json { render :show, status: :created, location: @show }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @show.errors, status: :unprocessable_entity }
        end
      end
    end  
  end

  def show
    @show = Show.find(params[:id])
  end

  def destroy
    @show = Show.find(params[:id])
    @show.destroy!

    respond_to do |format|
      format.html { redirect_to shows_path, status: :see_other, notice: "Show was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  private

  # Strong params to handle show fields
  def show_params
    params.require(:show).permit( :movie_id, :date, :time, :seats, :price)
  end
end
