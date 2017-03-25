require 'spec_helper'

RSpec.describe Hangman do
  let(:hangman) { Hangman.new }

  describe "Responds to input with correct reply" do
    it "responds to a word with 'youve guessed the word is....'" do
      expect(hangman.word_guess("hello")).to have_content("You've guessed the word is hello")
    end
  end
end
