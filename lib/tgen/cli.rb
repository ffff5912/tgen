require 'tgen'
require 'tgen/markov_chain'
require 'thor'

module Tgen
  class CLI < Thor
    desc "bundle exec exe/tgen generate text.txt", "text generate."
    def generate(text)
      path = File.expand_path(text)
      File.open(path) do |file|
        @read = file.read.gsub(/(\s)/,"")
      end
      mc = MarlkovChain.new
      words = mc.parse(@read)
      markov_table = mc.build_table(words)
    end
  end
end
