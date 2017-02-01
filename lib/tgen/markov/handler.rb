require 'tgen/markov/generator'
require 'tgen/markov/parser'
require 'tgen/markov/table'

module Markov
  MARKER_BEGIN = '__BOS__'
  MARKER_END = '__EOS__'
  class Handler
    def handle(text)
      texts = Parser.new.parse(text)
      table = Table.new.build(texts)
      text = Generator.new.generate(table)
    end
  end
end
