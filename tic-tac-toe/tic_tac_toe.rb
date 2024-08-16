require_relative "methods"

board = Array.new(3) { Array.new(3, " ") }
player = ""

print_board(board)
9.times do
  player = player == "X" ? "O" : "X"
  move(board, player)
  print_board(board)
  if check(board).positive?
    puts check(board) == 1 ? "---------- " << player << " win! ----------" : "---------- Draw ----------!"
    break
  end
end
