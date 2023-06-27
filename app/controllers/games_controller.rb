# require 'open-uri'

class GamesController < ApplicationController
  def new
    @vowels = %w[a e i o u].sample(3)
    @consonants = (('a'..'z').to_a - @vowels).sample(7)
    @letters = (@consonants + @vowels).shuffle
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    data = JSON.parse(URI.open(url).read)
    match_or_not = params[:word].chars.all? { |letter| params[:letters].include?(letter) }
    @word = params[:word].upcase
    @result = if data['found'] == true && match_or_not
                "Congratulations! #{@word} is a valid English word!"
              elsif data['found'] == true && match_or_not == false
                "Sorry but #{@word} can't be built out of #{params[:letters].upcase}"
              elsif data['found'] == false && match_or_not
                "Sorry but #{@word} doesn't seem to be a valid English word..."
              else
                "Sorry but #{@word} doesn't seem to be a valid English word or match any of the letters..."
              end
  end
end
