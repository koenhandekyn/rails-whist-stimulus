class RoundsController < ApplicationController
  before_action :set_round, only: [:show, :edit, :update, :destroy]

  # GET /rounds
  # GET /rounds.json
  def index
    @rounds = Round.all
  end

  # GET /rounds/1
  # GET /rounds/1.json
  def show
  end

  # GET /rounds/new
  def new
    @round = Round.new
  end

  # GET /rounds/1/edit
  def edit
  end

  # POST /rounds
  # POST /rounds.json
  def create
    @round = Round.new(round_params)
    respond_to do |format|
      if @round.save
        format.html {
          rounds = @round.game.rounds.order(created_at: :ASC)
          rounds_count = @round.game.rounds.count
          rounds_html = ApplicationController.render(partial: 'games/rounds', locals: { rounds: rounds, rounds_count: rounds_count })
          ActionCable.server.broadcast("game/#{@round.game.id}", { message: 'scores', scores: @round.game.scores, rounds_html: rounds_html } )
          redirect_to game_path(@round.game), notice: 'Round was successfully created.'
        }
        format.json { render :show, status: :created, location: @round }
      else
        format.html {
          @game = @round.game
          @rounds = @game.rounds.order(created_at: :ASC)
          @rounds_count = @game.rounds.count
          render 'games/show'
        }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rounds/1
  # PATCH/PUT /rounds/1.json
  def update
    @round.update!(round_params)
    respond_to do |format|
      format.html { redirect_to game_path(@round.game), notice: 'Round was successfully updated.' }
      format.json { render :show, status: :ok, location: @round }
    end
  rescue
    respond_to do |format|
      format.html { render :edit }
      format.json { render json: @round.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /rounds/1
  # DELETE /rounds/1.json
  def destroy
    game = @round.game
    @round.destroy
    respond_to do |format|
      format.html { redirect_to edit_game_path(game), notice: 'Round was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_round
      @round = Round.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def round_params
      params.require(:round).permit(:game_id, :score1, :score2, :score3, :score4, :roundtype)
    end
end
