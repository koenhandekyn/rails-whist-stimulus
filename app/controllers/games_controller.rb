class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    if (params[:player])
      player_id = Player.select('id').where(email: params[:player]).limit(1)
      @games = Game.where('owner_id = (?)', player_id).order(created_at: :DESC)
    else
      @games = Game.all.order(created_at: :DESC)
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @round = params[:round_id].blank? ? @game.rounds.new : Round.find(params[:round_id])
    @rounds = @game.rounds.order(created_at: :ASC)
    @rounds_count = @game.rounds.count
  end

  # GET /games/new
  def new
    @game = Game.new_from_ip(request.remote_ip)
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    if params[:game]
      @game = Game.create(game_params)
    else
      @game = Game.new_from_ip(request.remote_ip)
    end
    #
    if @game.save
      redirect_to game_path(@game) # with turbolinks
    else
      render layout: false, status: :bad_request
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    if @game.update(game_params)
      redirect_to game_path(@game) # with turbolinks
    else
      render layout: false, status: :bad_request
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    redirect_to games_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:player1, :player2, :player3, :player4, :name)
    end
end
