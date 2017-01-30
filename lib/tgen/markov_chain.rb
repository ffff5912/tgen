require 'natto'

class MarlkovChain
  def initialize
    @markov = []
    @words = []
  end

  def build_table(words)
    @markov = words.each_cons(3).to_a
  end

  def buildSentense(table)
    word1, word2 = *table.first
    result = word1 + word2

    loop {
      values = search(table, word1, word2)
      value = values[rand(0..(values.count - 1))]
      if value == ''
        break;
      end

      result += value
      word1 = word2
      word2 = value
    }

    result
  end

  def search(table, word1, word2)
    words = []
    table.select {|row|
      if row[0] == word1 && row[1] == word2
        words << row[2]
      end
    }
    words
  end

  def parse(text)
    words = []
    mecab = Natto::MeCab.new('-Owakati')
    mecab.parse(text) {|word|
      words << word.surface
    }
    words
  end
end
