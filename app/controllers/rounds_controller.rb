class RoundsController < ApplicationController
    include SessionHelper

    before_action :authorize, except: [:index, :show]

    def index
        @rounds = Round.all
    end

    def new
        @current_user = User.find(1)
        @round = Round.new(num_questions: 10)
        @round.build_empty_questions
    end

    def create
        @round = Round.new(round_params)

        if @round.save
            redirect_to round_path(@round)
        else
            @errors = @round.errors.full_messages
            @current_user = User.find(1)
            render :new
        end
    end

    def show
        set_round
    end
    
    def edit
        set_round
    end

    def update
        set_round
        @round.assign_attributes(round_params)
        if @round.save
            redirect_to round_path(@round)
        else
            @errors = @round.errors.full_messages
            render :edit
        end
    end

    def destroy
        set_round
        @round.destroy
        redirect_to rounds_path
    end

    private

    def set_round
        @round = Round.find(params[:id])
    end

    def round_params
        params.require(:round).permit(:name, :creator_id, :questions_attributes => [:question, :answer, :alt_answer, :creator_id])
    end
end