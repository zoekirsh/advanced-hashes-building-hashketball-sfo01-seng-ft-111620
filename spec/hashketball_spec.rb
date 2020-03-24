require 'spec_helper'
require 'pry'
describe 'hashketball' do
  let(:alan_anderson) {
    { :player_name => "Alan Anderson", :number => 0, :shoe => 16, :points => 22, :rebounds => 12, :assists => 12, :steals => 3, :blocks => 1, :slam_dunks => 1 }
  }

  let(:reggie_evans) {
    { :player_name => "Reggie Evans", :number => 30, :shoe => 14, :points => 12, :rebounds => 12, :assists => 12, :steals => 12, :blocks => 12, :slam_dunks => 7 }
  }

  let(:brook_lopez) {
    { :player_name => "Brook Lopez", :number => 11, :shoe => 17, :points => 17, :rebounds => 19, :assists => 10, :steals => 3, :blocks => 1, :slam_dunks => 15 }
  }

  let(:mason_plumlee) {
    { :player_name => "Mason Plumlee", :number => 1, :shoe => 19, :points => 26, :rebounds => 11, :assists => 6, :steals => 3, :blocks => 8, :slam_dunks => 5 }
  }

  let(:jason_terry) {
    { :player_name => "Jason Terry", :number => 31, :shoe => 15, :points => 19, :rebounds => 2, :assists => 2, :steals => 4, :blocks => 11, :slam_dunks => 1 }
  }

  let(:jeff_adrien) {
    { :player_name => "Jeff Adrien", :number => 4, :shoe => 18, :points => 10, :rebounds => 1, :assists => 1, :steals => 2, :blocks => 7, :slam_dunks => 2 }
  }

  let(:bismack_biyombo) {
    { :player_name => "Bismack Biyombo", :number => 0, :shoe => 16, :points => 12, :rebounds => 4, :assists => 7, :steals => 22, :blocks => 15, :slam_dunks => 10 }
  }

  let(:desagna_diop) {
    { :player_name => "DeSagna Diop", :number => 2, :shoe => 14, :points => 24, :rebounds => 12, :assists => 12, :steals => 4, :blocks => 5, :slam_dunks => 5 }
  }

  let(:ben_gordon) {
    { :player_name => "Ben Gordon", :number => 8, :shoe => 15, :points => 33, :rebounds => 3, :assists => 2, :steals => 1, :blocks => 1, :slam_dunks => 0 }
  }

  let(:kemba_walker) {
    { :player_name => "Kemba Walker", :number => 33, :shoe => 15, :points => 6, :rebounds => 12, :assists => 12, :steals => 7, :blocks => 5, :slam_dunks => 12 }
  }

  

  describe '#game_hash' do
    let(:top_level_keys) { [:home, :away] }
    let(:team_level_keys) { [:team_name, :colors, :players] }

    it 'returns a hash' do
      expect(game_hash).to be_a(Hash)
    end

    it 'returns the correct top-level keys' do
      top_level_keys.each do |key|
        expect(game_hash.keys).to include(key)
      end
    end

    it 'returns the correct team-level keys' do
      team_level_keys.each do |key|
        expect(game_hash.values.first.keys).to include(key)
      end
    end

    it 'returns the correct player data for the :home team' do
      home_players = [alan_anderson, reggie_evans, brook_lopez, mason_plumlee, jason_terry]
      names = game_hash[:home][:players].map {|player| player[:player_name]}

      home_players.each do |example_player_hash|
        expect(names).to include(example_player_hash[:player_name]), "Expected the name #{example_player_hash[:player_name]}, but could not find. Check the spelling of player names. Capitalization matters!"

        player_stats = game_hash[:home][:players].find do |player|
          player[:player_name] == example_player_hash[:player_name]
        end

        expect(player_stats.keys).to match_array(example_player_hash.keys)
        expect(player_stats.values).to match_array(example_player_hash.values)
      end
    end

    it 'returns the correct player data for the :away team' do
      away_players = [jeff_adrien, bismack_biyombo, desagna_diop, ben_gordon, kemba_walker]
      names = game_hash[:away][:players].map {|player| player[:player_name]}

      away_players.each do |example_player_hash|
        expect(names).to include(example_player_hash[:player_name])

        player_stats = game_hash[:away][:players].find do |player|
          player[:player_name] == example_player_hash[:player_name]
        end

        expect(player_stats.keys).to match_array(example_player_hash.keys)
        expect(player_stats.values).to match_array(example_player_hash.values)
      end
    end
  end
end
