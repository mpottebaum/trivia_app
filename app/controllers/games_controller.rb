class GamesController < ApplicationController
    include SessionHelper

    before_action :authorize, except: [:index, :show]

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