def print_board(board)
  puts "----------"
  board.each do |row|
    row.each do |element|
      print "|" << element.chr << " "
    end
    puts "|"
    puts "----------"
  end
end

# Return 0 if the game isn't over, 1 if someone win and 2 if the game ends in a draw
def check(board)
  # Check row
  board.each do |row|
    return 1 if row[0] != " " && row[0] == row[1] && row[0] == row[2]
  end
  # Check col
  (0..2).each do |col|
    return 1 if board[0][col] != " " && board[0][col] == board[1][col] && board[0][col] == board[2][col]
  end
  # Check diagonal
  if (board[1][1] != " " && board[0][0] == board[1][1] && board[1][1] == board[2][2]) ||
     (board[1][1] != " " && board[0][2] == board[1][1] && board[1][1] == board[2][0])
    return 1
  end

  # Check draw
  draw = true
  board.any? do |row|
    draw = false if row.any?(" ")
  end
  return draw ? 2 : 0
end

def move(board, player)
  loop do
    row = -1
    col = -1
    # Get row
    loop do
      print "Move at row: "
      row = gets.to_i
      break if row.between?(0, 2)

      puts "Invalid row"
    end

    # Get col
    loop do
      print "Move at column: "
      col = gets.to_i
      break if col.between?(0, 2)

      puts "Invalid column"
    end

    if board[row][col] == " "
      board[row][col] = player
      check(board)
      break
    end
    puts "Invalid move"
  end
end
