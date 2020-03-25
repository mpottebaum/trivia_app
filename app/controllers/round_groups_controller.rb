class RoundGroupsController < ApplicationController
    include SessionHelper

    before_action :authorize

    def index
        @user = current_user
    end
    
    def new
        @round_group = RoundGroup.new
    end
    
    def create
        @user = current_user
        @round_group = @user.round_groups.new(group_params)

        if @round_group.save
            redirect_to round_group_path(@round_group)
        else
            @errors = @round_group.errors.full_messages
            render :new
        end
    end

    def show
        @round_group = RoundGroup.find(params[:id])
    end
    
    def edit
        @round_group = RoundGroup.find(params[:id])
    end

    def update
        @round_group = RoundGroup.find(params[:id])
        @round_group.assign_attributes(group_params)

        if @round_group.save
            redirect_to round_group_path(@round_group)
        else
            @errors = @round_group.errors.full_messages
            render :edit
        end
    end

    def destroy
        @round_group = RoundGroup.find(params[:id])
        @round_group.destroy
        redirect_to round_groups_path
    end

    def save
        @round = Round.find(params[:round_id])
        @round_group_round = RoundGroupRound.create(
            round_group_id: save_params[:round_group_id],
            round_id: @round.id
            )
        redirect_to round_path(@round)
    end

    def remove
        @round_group_round = RoundGroupRound.find(params[:round_group_round_id])
        @round_group = @round_group_round.round_group
        @round_group_round.destroy
        redirect_to round_group_path(@round_group)
    end

    private

    def group_params
        params.require(:round_group).permit(:name)
    end

    def save_params
        params.require(:round_group_round).permit(:round_group_id)
    end
end