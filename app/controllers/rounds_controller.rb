class RoundsController < ApplicationController
    include SessionHelper

    before_action :authorize, except: [:index, :show]

    def index
        @rounds = Round.all
        @recent = Round.most_recent
        @played = Round.most_played
        @saved = Round.most_saved
    end

    def new
        set_current_user
        @numbers = (1..15).to_a
    end
    
    def questions
        @round = Round.new
        @round.build_empty_questions(params[:num_questions].to_i)
        render :questions
    end

    def create
        @round = current_user.rounds.new(round_params)

        if @round.save
            redirect_to round_path(@round)
        else
            @errors = @round.errors.full_messages
            set_current_user
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

    def set_current_user
        @current_user = User.find(current_user_id)
    end

    def round_params
        params.require(:round).permit(:name, :creator_id, :questions_attributes => [:question, :answer, :alt_answer, :creator_id])
    end
end