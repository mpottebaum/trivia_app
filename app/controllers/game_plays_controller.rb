class GamePlaysController < ApplicationController
    include SessionHelper

    before_action :authorize

    def start
        set_game
        session[:game_round_id] = @game.first_game_round_id
    end
    
    def new
        set_game
        set_current_game_round
    end
    
    def create
        set_game
        set_current_game_round
        if @game.next_round(@current_game_round)
            session[:game_round_id] = @game.next_round(@current_game_round).id
            redirect_to new_game_game_play_path(@game)
        else
            session.delete :game_round_id
            redirect_to game_game_plays_results_path(@game)
        end
    end
    
    def results
        set_game
        @round_plays = @game.current_round_plays(session[:current_user_id])
    end

    private

    def set_game
        @game = Game.find(params[:game_id])
    end

    def set_current_game_round
        @current_game_round = @game.game_rounds.find(session[:game_round_id])
    end
end