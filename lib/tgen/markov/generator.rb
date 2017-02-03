module Markov
  class Generator
    def generate(table)
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
  end
end
