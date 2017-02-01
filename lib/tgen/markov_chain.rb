require 'natto'

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
      text += suffix[2]
      break if suffix[2] == MARKER_END

      _, word1, word2 = *suffix
    }
    text.gsub(MARKER_BEGIN, '').gsub(MARKER_END, '')
  end

  def search(table, word1, word2)
    words = table.select {|row|
      row[0] == word1 && row[1] == word2
    }
  end

  def tagger
    @tagger = Natto::MeCab.new('-Owakati')
  end

  def parse(text)
    tagger.parse(text).split(' ')
  end
end
