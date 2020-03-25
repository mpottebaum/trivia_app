class GamesController < ApplicationController
    include SessionHelper

    before_action :authorize, except: [:index, :show]

    def index
        @games = Game.all
    end

    def new
        @numbers = (1..10).to_a
    end
    
    def rounds
        num_rounds = params[:num_rounds].to_i
        @rounds = Round.all
        @game = Game.new
        num_rounds.times do
            @game.game_rounds.build
        end
        render :rounds
    end

    def create
        @game = current_user.games.new(game_params)

        if @game.save
            @game.set_round_nums
            redirect_to game_path(@game)
        else
            @errors = @game.errors.full_messages
            @rounds = Round.all
            render :rounds
        end
    end

    def show
        set_game
    end
    
    def edit
        set_game
        @rounds = Round.all
    end
    
    def update
        set_game
        @game.game_rounds.destroy_all
        @game.assign_attributes(game_params)
        
        if @game.save
            @game.set_round_nums
            redirect_to game_path(@game)
        else
            @errors = @game.errors.full_messages
            @rounds = Round.all
            render :edit
        end
    end
    
    def destroy
        set_game
        @game.destroy
        redirect_to games_path
    end
    
    private
    
    def set_game
        @game = Game.find(params[:id])
    end

    def game_params
        params.require(:game).permit(:name, :game_rounds_attributes => [:round_id])
    end
end