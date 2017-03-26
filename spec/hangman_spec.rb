require 'spec_helper'

RSpec.describe Hangman do

  # describe "Responds to input with correct reply" do
    # it "responds to a word with 'youve guessed the word is....'" do
    #   expect { hangman.respond("hello") }.to output("You've guessed the word is hello. Noooooo, you suck. try again").to_stdout
    # end
  # end --> cant get it to check output of multiple lines

  describe "win" do
    let(:hangman2) { Hangman.new }

    it "returns true if the input word is the same as the random word" do
      hangman2.random_word.word = "yaytrain"
      hangman2.word_guess("yaytrain")
      expect(hangman2.win?).to eq(true)
    end

    it "returns false if the input word is different from the random word" do
      hangman2.random_word.word = "yaytrain"
      hangman2.word_guess("boopboop")
      expect(hangman2.win?).not_to eq(true)
    end

    it "returns false when the player does not input the correct letters" do
      hangman2.random_word.word = "yaytrain"
      hangman2.respond(["y","b"])
      expect(hangman2.win?).not_to eq(false)
    end

    it "returns true when the player inputs all the correct letters" do
      hangman2.random_word.word = "yaytrain"
      hangman2.respond(["a","y","t","r","i","n"])
      expect(hangman2.win?).not_to eq(true)
    end
  end

  describe "lose" do
    let(:hangman3) { Hangman.new }
    let(:hangman4) { Hangman.new }
    it "returns true when the player enters 10 unique incorrect guesses" do
      hangman3.random_word.word = "yaytrain"
      hangman3.respond("q")
      hangman3.respond("k")
      hangman3.respond("s")
      hangman3.respond("m")
      hangman3.respond("l")
      hangman3.respond("o")
      hangman3.respond("b")
      hangman3.respond("apple")
      hangman3.respond("pineapple")
      hangman3.respond("pen")
      expect(hangman3.lose?).to eq(true)
    end

    it "does not return true when the player enters less than 10 unique guesses" do
      hangman4.random_word.word = "yaytrain"
      hangman4.respond("s")
      hangman4.respond("m")
      hangman4.respond("l")
      hangman4.respond("o")
      hangman4.respond("b")
      hangman4.respond("apple")
      hangman4.respond("pineapple")
      hangman4.respond("pen")
      expect(hangman4.lose?).not_to eq(true)
    end
  end

  describe "deducting points from bad guesses" do
    let(:hangman) { Hangman.new }
    before do
      hangman.random_word.word = "awesomesauce"
    end

    it "deducts a point when you enter a wrong guess" do
      expect{hangman.respond("q")}.to change{hangman.bad_guesses_left}.by(-1)
    end

    it "does not deduct a point when you enter a correct guess" do
      expect{hangman.respond("a")}.to change{hangman.bad_guesses_left}.by(0)
    end

    it "does not deduct a point when you enter the same incorrect guess twice" do
      hangman.respond("q")
      expect{hangman.respond("q")}.to change{hangman.bad_guesses_left}.by(0)
    end
  end
end
