class GamesController < ApplicationController
  def new
    @vowels = %w[a e i o u].sample(3)
    @consonants = (('a'..'z').to_a - @vowels).sample(7)
    @letters = (@consonants + @vowels).shuffle
  end

  def score
  end
end
