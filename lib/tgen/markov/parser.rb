require 'natto'

module Markov
  class Parser
    def tagger
      @tagger = Natto::MeCab.new('-Owakati')
    end

    def parse(text)
      tagger.parse(text).split(' ')
    end
  end
end
