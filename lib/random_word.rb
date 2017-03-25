class RandomWord
  attr_reader :word

  WORDS = %w(programming monkeybusiness rubyesque styleguide)

  def initialize
    @word = WORDS.sample
  end

  def positions_for(characters)
    word_array = @word.split("")
    guessed_positions = []
    characters.each do |character|
      i = 0
      word_array.each do |letter|
        if word_array[i] == character
          guessed_positions << i
        end
        i += 1
      end
    end
    guessed_positions
  end
end
