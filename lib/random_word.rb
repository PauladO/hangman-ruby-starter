class RandomWord
  attr_accessor :word

  # WORDS = %w(programming monkeybusiness rubyesque styleguide)
  WORDS = %w(programming monkeybusiness rubyesque styleguide)

  def initialize(word = WORDS.sample)
    @word = word
  end

  def array_of_word
    @word.split("")
  end

  def positions_for(characters = [])
    word_array = array_of_word
    guessed_positions = []

    word_array.each do |letter|
      if characters.include?(letter)
        guessed_positions << letter
      else
        guessed_positions << ""
      end
    end
    puts "display for word #{guessed_positions}"
    guessed_positions
  end
end
