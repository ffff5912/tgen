module Markov
  class Table
    def build(texts)
      words = [MARKER_BEGIN, *texts, MARKER_END]
      words.each_cons(3).to_a
    end
  end
end
