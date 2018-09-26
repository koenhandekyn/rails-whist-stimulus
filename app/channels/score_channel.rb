class ScoreChannel < ApplicationCable::Channel
  def subscribed
    puts "subscribed to game/#{params[:game_id]}"
    stream_from "game/#{params[:game_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def update
  end
end
