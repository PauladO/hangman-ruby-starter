class RandomWord
  attr_accessor :word

  WORDS = %w(programming monkeybusiness rubyesque styleguide homebrew)

  def initialize(word = WORDS.sample)
    @word = word
  end

  def array_of_word
    @word.split("")
  end

  def positions_for(characters = [])
    @guessed_positions = []
    array_of_word.each do |letter|
      if characters.include?(letter)
        @guessed_positions << letter
      else
        @guessed_positions << ""
      end
    end
    @guessed_positions
  end
end
