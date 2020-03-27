require 'rails_helper'

describe "Views", type: :feature do
    before(:each) do
        @round_1 = Round.create(name: "Round One")
    end
    
    it "rounds index page" do
        visit rounds_path
        expect(page).to have_content('Rounds')
    end

    it "games index page" do
        visit games_path
        expect(page).to have_content('Games')
    end

    it "rounds show page" do
        visit round_path(@round_1)
        expect(page).to have_content(@round_1.name)
    end

    it "rounds edit page unaccessible when not logged in" do
        visit edit_round_path(@round_1)
        current_path.should == login_path
    end

    it "rounds new page unaccessible when not logged in" do
        visit new_round_path
        current_path.should == login_path
    end
end