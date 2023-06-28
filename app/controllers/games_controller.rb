require 'open-uri'

class GamesController < ApplicationController
  def new
    @vowels = Array.new(3) { %w[a e i o u].sample }
    @consonants = Array.new(7) { (('a'..'z').to_a - @vowels).sample }
    @letters = (@consonants + @vowels).shuffle
  end

  def reset
    session[:scores] = []
    redirect_to root_path
  end

  def score
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    data = JSON.parse(URI.open(url).read)
    match_or_not = @word.downcase.chars.all? do |letter|
      params[:letters].count(letter) >= @word.count(letter)
    end

    @result = if data['found'] && match_or_not
                "Congratulations! #{@word.upcase} is a valid English word!"
              elsif data['found'] && !match_or_not
                "Sorry but #{@word.upcase} can't be built out of #{params[:letters].upcase}"
              elsif !data['found'] && match_or_not
                "Sorry but #{@word.upcase} doesn't seem to be a valid English word..."
              else
                "Sorry but #{@word.upcase} doesn't seem to be a valid English word or match any of the letters..."
              end

    session[:scores] ||= []
    session[:scores] << data['length'] if data['found'] && match_or_not
    @current_score = session[:scores].sum
  end
end
