class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy ]

  # GET /tickets or /tickets.json
  def index
    if(params[:show_id])
      @shows = Show.find_by(id: params[:show_id])
      @tickets= @shows.tickets
      @movie = @shows.movie
    else 
      @tickets=Ticket.all
    end 
  end

  # GET /tickets/1 or /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
    if(params[:show_id])
      @show = Show.find(params[:show_id])
    end
  end

  # GET /tickets/1/edit
  def edit
    
    #@movie = Movie.find(params[:movie_id])  # Find the movie by ID
    @ticket = Ticket.find(params[:id])
    @show = @ticket.show

  end

  # POST /tickets or /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.confirmation_number=generate_confirmation_number

    
    @show = Show.find_by(id: @ticket.show_id)  # Find the corresponding show
    puts "#{@show.available_seats}"
    puts "#{@ticket.number_of_tickets}"
    if @show.available_seats >= @ticket.number_of_tickets
      @ticket.show.available_seats -= @ticket.number_of_tickets  # Deduct available seats
      @ticket.show.save  # Save the updated show

      respond_to do |format|
        if @ticket.save
          format.html { redirect_to movie_show_tickets_path(@show.movie, @show, @ticket), notice: "Ticket successfully purchased." }
          format.json { render :show, status: :created, location: @ticket }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @ticket.errors, status: :unprocessable_entity }
        end
      end
    else 
      flash[:alert]="Not enough seats available to purchase the required number of tickets. Available seats: #{@ticket.show.available_seats}"
      redirect_to tickets_path

    end
  end

  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update
    #@movie = Movie.find(params[:movie_id])  # Find the movie by ID
    @ticket = Ticket.find(params[:id])
    @show = @ticket.show
    # Store the old number of tickets and status before updating
    old_number_of_tickets = @ticket.number_of_tickets
    old_status = @ticket.status
  
    respond_to do |format|
      if @ticket.update(ticket_params)  # Assuming ticket_params is your strong parameter method
        # Adjust the available seats only if the number of tickets has changed
        if old_number_of_tickets != @ticket.number_of_tickets
          # Calculate the difference between old and new ticket quantities
          difference = @ticket.number_of_tickets - old_number_of_tickets
  
          # Update available seats based on the difference
          @show.available_seats -= difference
          @show.save  # Save the updated show
        end
  
        # Handle ticket cancellation scenario
        if old_status != "Cancelled" && @ticket.status == "Cancelled"
          # If the ticket status has changed to "Cancelled," increase available seats
          @show.available_seats += @ticket.number_of_tickets
          @show.save  # Save the updated show
        end
  
        format.html { redirect_to movie_show_ticket_path(@show.movie, @show, @ticket), notice: "Ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end
  
  

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    #@movie = Movie.find(params[:movie_id])  # Find the movie by ID
    @ticket = Ticket.find(params[:id])
    @show = @ticket.show
    respond_to do |format|
      # Before destroying the ticket, adjust the available seats
      @show.available_seats += @ticket.number_of_tickets
      @show.save  # Save the updated show with the new available seats
  
      if @ticket.destroy
        format.html { redirect_to movie_show_tickets_path(@show.movie, @show), notice: "Ticket was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to movie_show_tickets_path(@show.movie, @show), alert: "Ticket could not be destroyed." }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def generate_confirmation_number
      # Generates a random alphanumeric string of length 10 (you can adjust the length as needed)
      SecureRandom.alphanumeric(10).upcase
    end
    

    def ticket_params
      params.require(:ticket).permit(:user_id, :show_id, :number_of_tickets, :status)
    end
end