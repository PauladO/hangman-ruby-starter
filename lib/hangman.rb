require File.expand_path("../random_word", __FILE__)

class Hangman
  def initialize
    @random_word = RandomWord.new
    @bad_guesses_left = 10
    @guessed_letters = []
    @word_display = @random_word.positions_for(@guessed_letters)
  end

  def play!
    puts "Let's play Hangman!\nYou can type a letter or a word as a guess.\nWhat's your first guess?"
    respond(gets.chomp)
    while !lose? && !win?
      respond(get_letter)
      print_score
    end
    if win?
      puts "yeaaah! you won! woohooo!"
    else
      puts "you looooose! booooo!"
    end
  end

  def get_letter
    puts "what's your next guess?"
    gets.chomp
  end

  def respond(input)
    if input.length > 1
      word_guess(input)
    elsif @guessed_letters.include?(input)
      puts "you've already guessed that"
      return
    elsif @random_word.array_of_word.include?(input)
      puts "that's correct"
    else
      puts "that's incorrect"
      @bad_guesses_left -= 1
    end
    display_word(input)
  end

  def word_guess(word)
    puts "You've guessed the word is #{word}"
    if @random_word.word == word
      puts "That is correct!"
      @win = true
    else
      puts "noooooo, you suck. try again"
      @bad_guesses_left -= 1
    end
  end

  def display_word(letter)
    @guessed_letters << letter
    @word_display = @random_word.positions_for(@guessed_letters)
    @word_display.each do |letter|
      if letter == ""
        print " - "
      else
        print " #{letter} "
      end
    end
    puts "\n"
  end

  def print_score
    puts "You have #{@bad_guesses_left} guesses left"
  end

  def win?
    @word_display == @random_word.array_of_word || @win
  end

  def lose?
    @bad_guesses_left == 0
  end
end
