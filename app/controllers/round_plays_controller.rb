class RoundPlaysController < ApplicationController
    def new
        set_round
    end

    def create
        set_round
        @round_play = RoundPlay.create(round: @round, user_id: 1)
        @round_play.score_round(answer_params)
        if session[:game_round_id]
            game_round = GameRound.find(session[:game_round_id])
            GameRoundPlay.create(round_play: @round_play, game: game_round.game)
        end
        flash[:answers] = answer_params[:questions]
        redirect_to round_round_play_path(@round, @round_play)
    end

    def show
        set_round
        set_round_play
        if session[:game_round_id]
            game_round = GameRound.find(session[:game_round_id])
            @game = game_round.game
        end
    end

    private

    def set_round
        @round = Round.find(params[:round_id])
    end

    def set_round_play
        @round_play = RoundPlay.find(params[:id])
    end

    def answer_params
        params.require(:round).permit(:questions => [:id, :answer])
    end
end