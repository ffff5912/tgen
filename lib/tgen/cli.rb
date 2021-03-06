require 'tgen'
require 'tgen/markov/handler'
require 'thor'

module Tgen
  class CLI < Thor
    desc "bundle exec exe/tgen generate text.txt", "text generate."
    def generate(text, max)
      path = File.expand_path(text)
      File.open(path) do |file|
        @read = file.read.gsub(/(\s)/,"")
      end
      text = Markov::Handler.new.handle(@read, max)
      p text
    end
  end
end
