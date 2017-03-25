require File.expand_path("../random_word", __FILE__)

class Hangman
  def initialize
    @random_word = RandomWord.new
    @bad_guesses_left = 10
    @guessed_letters = []
    @word_display = @random_word.positions_for(@guessed_letters)
    @word_array = @random_word.array_of_word
  end

  def play!
    puts "Hi from lib/hangman.rb!"
    puts @random_word.word
    while  !lose? && !win? && !@win
      respond(get_letter)
      print_score
      puts @guessed_positions
    end
    if win? || @win
      puts "yeaaah! you won! woohooo!"
    else
      puts "you looooose! booooo!"
    end
  end

  def print_score
    puts "You have #{@bad_guesses_left} guesses left"
  end

  def win?
    @word_display == @word_array
  end

  def lose?
    @bad_guesses_left == 0
  end

  def get_letter
    puts "What's your next guess?"
    gets.chomp
  end

  def respond(input)
    if input.length > 1
      word_guess(input)
    elsif @guessed_letters.include?(input)
      puts "you've already guessed that"
      return
    elsif @word_array.include?(input)
      puts "that's correct"
    else
      puts "that's incorrect"
      @bad_guesses_left -= 1
    end
    display_word(input)
  end

  def display_word(letter)
    @guessed_letters << letter
    @word_display = @random_word.positions_for(@guessed_letters)
    @word_display.each do |letter|
      if letter == ""
        print "-"
      else
        print letter
      end
    end
    puts "\n"
  end

  def word_guess(word)
    puts "You've guessed the word is #{word}"
    if @random_word.word == word
      puts "you guessed it!"
      @win = true
    else
      puts "noooooo"
      @bad_guesses_left -= 1
    end
  end
end
