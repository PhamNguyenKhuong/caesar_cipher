def random_word
  file = File.open("google-10000-english-no-swears.txt", "r")
  words = []
  file.each_line do |line|
    words << line.chomp if line.chomp.length.between?(MIN_LETTERS, MAX_LETTERS)
  end
  words.sample
end

def get_guess(used_word)
  guess_letter = gets.downcase.chomp
  return "save" if guess_letter == "save"

  until guess_letter.match?(/^[a-z]$/)
    print "Invalid guess, please input a letter: "
    guess_letter = gets.downcase.chomp
  end
  while used_word.include?(guess_letter)
    puts "You've already tried that letter!".colorize(:yellow)
    print "Enter a letter: "
    guess_letter = gets.downcase.chomp
  end
  guess_letter
end

# Return false if the player lose, otherwise true
def begin_from_attempt(attempt, key, guess, correct, incorrect)
  (attempt.to_i..MAX_GUESSES).each do |i|
    print_status(guess, correct, incorrect)

    if make_attempt(i, key, guess, correct, incorrect) == "save"
      save_game(key, guess, i, correct, incorrect)
      return true
    end

    if endgame?(guess)
      puts "Congratulations!! The orrect result is #{guess}".colorize(:green)
      return true
    end
  end
  false
end

def make_attempt(attempt, key, guess, correct, incorrect)
  puts "Attempt: #{attempt}/#{MAX_GUESSES}".colorize(:light_blue)
  print "Enter a letter or enter 'save' to save game: "

  guess_letter = get_guess(correct + incorrect)
  return "save" if guess_letter == "save"

  if key.include?(guess_letter)
    correct << guess_letter
    key.length.times { |i| guess[i] = guess_letter if key[i] == guess_letter }
    puts "Correct!".colorize(:green)
  else
    incorrect << guess_letter
    puts "Incorrect!".colorize(:red)
  end
  "continue"
end

def print_status(guess, correct, incorrect)
  puts "___________________________________________________".colorize(:light_blue)
  puts
  puts "Your guess: #{guess}"
  puts
  ("a".."z").to_a.each do |letter|
    if correct.include?(letter)
      print "#{letter} ".colorize(:green)
    elsif incorrect.include?(letter)
      print "#{letter} ".colorize(:red)
    else
      print "#{letter} ".colorize(:grey)
    end
  end
  puts "\n\n"
end

def endgame?(guess)
  !guess.include?("_")
end
