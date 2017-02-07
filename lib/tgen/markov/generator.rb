module Markov
  class Generator
    def generate(table, max)
      word1, word2 = *table.first
      text = word1 + word2
      loop {
        texts = search(table, word1, word2)
        break if texts.empty?
        next_text = texts[rand(texts.size)]
        break if remove_marker(text + next_text[2]).size > max.to_i
        text += next_text[2]
        break if next_text[2] == MARKER_END
        _, word1, word2 = *next_text
      }
      remove_marker(text)
    end

    def search(table, word1, word2)
      words = table.select {|row|
        row[0] == word1 && row[1] == word2
      }
    end

    def remove_marker(text)
        text.gsub(MARKER_BEGIN, '').gsub(MARKER_END, '')
    end
  end
end
