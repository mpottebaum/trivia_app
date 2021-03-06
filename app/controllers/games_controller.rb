class GamesController < ApplicationController
    include SessionHelper

    before_action :authorize, except: [:index, :show]

    def index
        @games = Game.all
        @recent = Game.most_recent
        @played = Game.most_played
    end

    def new
        @numbers = (1..10).to_a
        @round_groups = current_user.round_groups
    end
    
    def rounds
        num_rounds = params[:num_rounds].to_i
        @rounds = Round.compile_rounds_from_round_groups(params[:round_group_ids])
        @game = Game.new
        num_rounds.times do
            @game.game_rounds.build
        end
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