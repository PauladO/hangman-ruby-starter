require 'spec_helper'

RSpec.describe RandomWord do
  let(:random_word) { RandomWord.new }

  it "generates a random word from the WORDS list" do
    expect(RandomWord::WORDS).to include(random_word.word)
  end

  describe "#positions_for(characters: [])" do
    let!(:random_word) { RandomWord.new("homebrew") }

    it "returns the character positions for all passed in characters" do
      expect(random_word.positions_for(["e"])).to eq(["", "", "", "e", "", "", "e", ""])
    end
  end
end
