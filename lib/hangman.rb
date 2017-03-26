require File.expand_path("../random_word", __FILE__)

class Hangman
  attr_accessor :random_word
  attr_reader :bad_guesses_left

  def initialize
    @random_word = RandomWord.new
    @bad_guesses_left = 10
    @guessed_letters = []
    @word_display = @random_word.positions_for(@guessed_letters)
  end

  def play!
    puts "Let's hang this man!\nYou can type a letter or a word as a guess.\nWhat's your first guess?"
    respond(gets.chomp)
    print_score
    while !lose? && !win?
      respond(get_letter)
      print_score
    end
    if win?
      puts "yeaaah! you won! woohooo!"
    end
  end

  def get_letter
    puts "what's your next guess?"
    gets.chomp
  end

  def respond(input)
    if already_guessed?(input)
      puts "you've already guessed that"
    elsif is_a_word?(input)
      word_guess(input)
    elsif letter_is_in_word?(input)
      puts "that's correct"
    else
      puts "that's incorrect"
      @bad_guesses_left -= 1
    end
    display_word(input)
  end


  def word_guess(word)
    puts "You've guessed the word is #{word}. "
    if @random_word.word == word
      puts "That is correct!"
      @win = true
    else
      puts "Not that word. Come on, his life depends on it!"
      @bad_guesses_left -= 1
    end
  end

  def display_word(new_letter)
    guessed_letters_in_position(new_letter).each do |letter|
      if letter == ""
        print " - "
      else
        print " #{letter} "
      end
    end
    puts "\n"
  end

  def guessed_letters_in_position(new_letter)
    @guessed_letters << new_letter
    @random_word.positions_for(@guessed_letters)
  end

  def print_score
    killing_it
    puts "You have #{@bad_guesses_left} guesses left"
  end

  def is_a_word?(input)
    input.length > 1
  end

  def already_guessed?(input)
    @guessed_letters.include?(input)
  end

  def letter_is_in_word?(input)
    @random_word.array_of_word.include?(input)
  end

  def win?
    @word_display == @random_word.array_of_word || @win
  end

  def lose?
    @bad_guesses_left == 0
  end

  def killing_it
    case @bad_guesses_left
    when 10
      puts "____\nNothing to see here..."
    when 9
      puts "|\n|\n|____\nConstruction has started."
    when 8
      puts "|\n|\n|\n|\n|____\nDeath has been informed."
    when 7
      puts "___\n| \n|\n|\n|\n|____\nStructure completed"
    when 6
      puts "___\n| |\n| \n|\n|\n|____\nHanging the rope"
    when 5
      puts "___\n| |\n| O\n|\n|\n|____\nTied the noose"
    when 4
      puts "___\n| |\n| O\n| ∆\n|\n|____\nOh you are failing!"
    when 3
      puts "___\n| |\n| O\n|/∆\n|\n|____\nDeath to the little man!"
    when 2
      puts "___\n| |\n| O\n|/∆\\\n|\n|____\nI guess he deserves it."
    when 1
      puts "___\n| |\n| O\n|/∆\\\n|/ \n|____\nHis days are counted."
    when 0
      puts "___\n| |\n| O\n|/∆\\\n|/ \\\n|____\nCongratulations! It dead."
    end
  end
end
