class RoundsController < ApplicationController
  before_action :set_round, only: [:show, :edit, :update, :destroy]

  # GET /rounds
  # GET /rounds.json
  def index
    raise "not supported"
  end

  # GET /rounds/1
  # GET /rounds/1.json
  def show
    raise "not supported"
  end

  # GET /rounds/new
  def new
    raise "not supported"
  end

  # GET /rounds/1/edit
  def edit
  end

  # POST /rounds
  # POST /rounds.json
  def create
    @round = Round.new(round_params)
    @round.save!
    notify_clients
    head :ok
  rescue
    render layout: false, status: :bad_request
  end

  # PATCH/PUT /rounds/1
  # PATCH/PUT /rounds/1.json
  def update
    @round.update!(round_params)
    notify_clients
    redirect_to game_path(@round.game) # with turbolinks
  rescue
    render layout: false, status: :bad_request
  end

  # DELETE /rounds/1
  # DELETE /rounds/1.json
  def destroy
    game = @round.game
    @round.destroy
    redirect_to edit_game_path(game), notice: 'Round was successfully destroyed.'
  end

  private

    def notify_clients
      rounds = @round.game.rounds.order(created_at: :ASC)
      rounds_count = @round.game.rounds.count
      rounds_html = ApplicationController.render(partial: 'games/rounds', locals: { rounds: rounds, rounds_count: rounds_count })
      ActionCable.server.broadcast("game/#{@round.game.id}", { message: 'scores', scores: @round.game.scores, rounds_html: rounds_html } )
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_round
      @round = Round.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def round_params
      params.require(:round).permit(:game_id, :score1, :score2, :score3, :score4, :roundtype)
    end
end
