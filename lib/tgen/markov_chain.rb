require 'natto'
require 'pp'
class MarlkovChain
  MARKER_BEGIN = '__BOS__'
  MARKER_END = '__EOS__'

  def initialize
  end

  def build_table(words)
    words = [MARKER_BEGIN, *words, MARKER_END]
    words.each_cons(3).to_a
  end

  def buildSentense(table)
    word1, word2 = *table.first
    text = word1 + word2

    loop {
      texts = search(table, word1, word2)
      break if texts.empty?
      suffix = texts[rand(texts.size)]
      break if suffix[2] == ''
      text += suffix[2]
      break if suffix[2] == MARKER_END

      _, word1, word2 = *suffix
    }
    text.sub(MARKER_BEGIN, '')
  end

  def search(table, word1, word2)
    words = table.select {|row|
      row[0] == word1 && row[1] == word2
    }
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
