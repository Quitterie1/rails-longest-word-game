require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def check_letters(grid, word)
    word.upcase.split(//).each do |letter|
      if grid.include?(letter)
        grid.delete_at(grid.index(letter) || grid.length)
      else
        return false
      end
    end
    return true
  end

  def check_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    dictionnary = open(url).read
    return JSON.parse(dictionnary)
  end

  def score
    @grid = params[:letters].split(//)
    @word = params[:word]
    check_l = check_letters(@grid, @word)
    if check_l == false
      @answer = "Sorry #{@word.upcase} can't be built out of the letters #{@grid}"
    else
      check_w = check_word(@word)
      if check_w["found"] == true
        @answer = "CONGRATULATIONS! #{@word.upcase} is a valid english word!"
      else
        @answer = "Sorry but #{@word.upcase} does not seems to be a valid english word."
      end
    end
  end

end
