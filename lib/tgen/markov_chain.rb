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

  def buildSentense(table)
    key = [];
    key << table[0][0]
    key << table[0][1]

    result = key[0] + key[1]

    while true do
      values = search(table, key)
      value = values[rand(0..(values.count - 1))]
      if value == ''
        break;
      end

      result += value
      key[0] = key[1]
      key[1] = value
    end

    result
  end

  def search(table, key)
    values = []
    table.each {|row|
      if row[0] == key[0] && row[1] == key[1]
        values << row[2]
      end
    }
    values
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
