require "colorize"
require "json"
require_relative "support"

MAX_GUESSES = 10
MAX_LETTERS = 12
MIN_LETTERS = 5

def new_game
  key = random_word
  puts "Key generated!".colorize(:blue)
  guess = ""
  incorrect = []
  correct = []
  key.length.times { guess << "_" }
  puts "You lost".colorize(:red) + "\nResult:    #{key}" unless begin_from_attempt(1, key, guess, correct, incorrect)
end

def open_game
  print "Enter file name: ".colorize(:blue)
  file_name = gets.chomp
  File.open("#{file_name}.json", "r") do |file|
    data = JSON.parse(file.read).transform_keys(&:to_sym)
    unless begin_from_attempt(data[:attempt], data[:key], data[:guess], data[:correct], data[:incorrect])
      puts "You lost".colorize(:red) + "\nResult:    #{data[:key]}"
      File.delete("#{file_name}.json")
    end
  end
end

def save_game(key, guess, attempt, correct, incorrect)
  print "Enter save name: ".colorize(:blue)
  file_name = gets.chomp
  File.open("#{file_name}.json", "w") do |file|
    json = {
      key: key,
      guess: guess,
      attempt: attempt,
      correct: correct,
      incorrect: incorrect
    }.to_json
    file.puts json
  end
end

puts "\n                      HANGMAN".colorize(:blue)
print "Press 1 to start a new game or 2 to open a saved game: ".colorize(:blue)
option = gets.to_i
until [1, 2].include?(option)
  print "Press 1 to start a new game or 2 to open a saved game: ".colorize(:blue)
  option = gets
end
option == 1 ? new_game : open_game
