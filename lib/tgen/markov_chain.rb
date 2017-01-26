require 'natto'

class MarlkovChain
  def initialize
    @markov = []
    @words = []
  end

  def build_table(words)
    words.each_cons(3) {|pre_f, pre_s, suffix|
      @markov << [pre_f, pre_s, suffix]
    }
    @markov
  end

  def parse(text)
    words = []
    mecab = Natto::MeCab.new
    mecab.parse(text) {|word|
      words << word.surface
    }
    words
  end
end
