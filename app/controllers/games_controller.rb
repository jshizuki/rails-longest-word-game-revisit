# require 'open-uri'

class GamesController < ApplicationController
  def new
    @vowels = %w[a e i o u].sample(3)
    @consonants = (('a'..'z').to_a - @vowels).sample(7)
    @letters = (@consonants + @vowels).shuffle
  end

  def score
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    data = JSON.parse(URI.open(url).read)
    match_or_not = @word.downcase.chars.all? { |letter| params[:letters].include?(letter) }
    @result = if data['found'] == true && match_or_not
                "Congratulations! #{@word.upcase} is a valid English word!"
              elsif data['found'] == true && match_or_not == false
                "Sorry but #{@word.upcase} can't be built out of #{params[:letters].upcase}"
              elsif data['found'] == false && match_or_not
                "Sorry but #{@word.upcase} doesn't seem to be a valid English word..."
              else
                "Sorry but #{@word.upcase} doesn't seem to be a valid English word or match any of the letters..."
              end
  end
end
