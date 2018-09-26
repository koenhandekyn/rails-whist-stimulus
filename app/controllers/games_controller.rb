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
    @game = Game.new(player1: Faker::Name.first_name,
                         player2: Faker::Name.first_name,
                         player3: Faker::Name.first_name,
                         player4: Faker::Name.first_name,
                         name: name_from_ip(request.remote_ip))
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
      @game = Game.create!(player1: Faker::Name.first_name,
                           player2: Faker::Name.first_name,
                           player3: Faker::Name.first_name,
                           player4: Faker::Name.first_name,
                           name: name_from_ip(request.remote_ip))
    end
    respond_to do |format|
      if @game.save
        format.html { redirect_to game_path(@game), notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to game_path(@game), notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
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

    def name_from_ip(ip)
      response = HTTParty.get("http://api.ipstack.com/#{ip}?access_key=2d186e4c34beb6881385a1a65698f023")
      location = "#{response["city"]}/#{response["country_name"]}" if response["city"]
      "#{location}@#{Time.zone.now.to_date.to_s(:short)}"
    end
end
