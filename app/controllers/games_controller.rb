class GamesController < ApplicationController

    def index
        @games = Game.all
    end

    def new
        @game = Game.new
    end

    def create
    end

    def show
        @game = Game.find(params[:id])
    end

    def edit
    end

    def update
    end

    def destroy
    end
end