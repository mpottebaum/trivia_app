class GamePlaysController < ApplicationController

    def start
        @game = Game.find(params[:game_id])
        session[:game_round_id] = @game.game_round_ids.first
    end
    
    def new
        @game = Game.find(params[:game_id])
        @current_game_round = @game.game_rounds.find(session[:game_round_id])
    end
    
    def create
        @game = Game.find(params[:game_id])
        current_game_round = @game.game_rounds.find(session[:game_round_id])
        if @game.game_rounds.find_by(round_num: (current_game_round.round_num + 1))
            session[:game_round_id] = @game.game_rounds.find_by(round_num: (current_game_round.round_num + 1)).id
            redirect_to new_game_game_play_path(@game)
        else
            session.delete :game_round_id
            redirect_to game_game_plays_results_path(@game)
        end
    end
    
    def results
        @game = Game.find(params[:game_id])
        @round_plays = @game.round_plays.where(user_id: 1)
    end
end