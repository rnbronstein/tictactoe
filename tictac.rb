class Play
  #my favorite constant to save me all the time!
   EMPTY_CELL = ' '

#SETTING UP THE PLAYERS & BOARD
def initialize(current_player)
  @current_player = current_player
  @board = Array.new(3) {
  Array.new(3) { EMPTY_CELL }
  }
end

# Display board & values
def display_board
  puts "-" * 13
  for row in 0..2
    print "| "
    for col in 0..2
      cell = @board[row][col]
      if cell == EMPTY_CELL
        print col + (row * 3) + 1
      else
        print cell
      end
      print " | "
    end
    puts "\n" + ("-" * 13)
  end
end

#BEFORE MAKING A MOVE, WE NEED TO SEE IF THE GAME HAS ENDED
  # Check for a full board
def board_full?
  for row in 0..2
    for col in 0..2
      # Board_full = false when there are empty positions
      if @board[row][col] == EMPTY_CELL
         return false
      end
    end
  end   
  #Return true when there are no empty positions
   return true
end

# Find a winning set. We need to find a match of three within the correct row/col placements 
def winner?
  (0..2).each do |i|
     # check along columns
    if @board[i][0] == @board[i][1] && @board[i][1] == @board[i][2]
      # Get the marker value for the first set unless the whole set = empty
      return @board[i][0] unless @board[i][0] == EMPTY_CELL
     # check along rows
    elsif @board[0][i] == @board[1][i] && @board[1][i] == @board[2][i]
      return @board[0][i] unless @board[0][i] == EMPTY_CELL
    end
  end

 # check specific places for diagonals
  if ( @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] ) || 
    ( @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0] )
      return @board[1][1] unless @board[1][1] == EMPTY_CELL
    end

  # set to false or the game stops running after one move
  return false
end

def tie?
  board_full? && !winner?
end


#MAKING A MOVE

#see if move is off board
def invalid?(move)
  (move < 0) || (move > 9)
end

#check to see if spot is taken
def is_empty?(row,col)
  @board[row][col] == EMPTY_CELL
end

#Prompt current player for a move. 
def prompt_move(current_player)
  played = false
  while not played
    puts "Player " + @current_player + ": Choose a position to play or type 'quit' to quit."
    move = STDIN.gets.chomp
      if move == "quit"
        exit
      else
        move = move.to_i - 1
        # Turn move into row/col coordinate
        col = move % @board.size
        row = (move - col) / @board.size
          if invalid?(move)
            puts "That spot is invalid. Please pick another position."
            played = false
          elsif is_empty?(row,col)
            #Put current player's mark on space
            @board[row][col] = @current_player
            played = true
          else
            puts "That spot is taken. Please pick another position."
            played = false
          end
      end
  end
end


#Switch players
def get_next_turn
  if @current_player == 'X'
    @current_player = 'O'
  else
    @current_player = 'X'
  end
  return @current_player
end


# Call the outcome of the game
def call_game
  if winner?
    puts "Player #{winner?} wins!"
    puts " 
  
 _______  _______  __    _  _______  ______    _______  _______  _______  __  
|       ||       ||  |  | ||       ||    _ |  |   _   ||       ||       ||  | 
|       ||   _   ||   |_| ||    ___||   | ||  |  |_|  ||_     _||  _____||  | 
|       ||  | |  ||       ||   | __ |   |_||_ |       |  |   |  | |_____ |  | 
|      _||  |_|  ||  _    ||   ||  ||    __  ||       |  |   |  |_____  ||__| 
|     |_ |       || | |   ||   |_| ||   |  | ||   _   |  |   |   _____| | __  
|_______||_______||_|  |__||_______||___|  |_||__| |__|  |___|  |_______||__| ".force_encoding("US-ASCII")
    puts "Game over."
  elsif tie?
    puts "It's a tie!"
    puts "Game over."
  end
end

#Prompt player to see if they want to play / restart game
def play_game?
  puts "Want to play tic tac toe?"
  response = STDIN.gets.chomp.downcase
  if response == "yes"
    return true
  else 
    exit
  end
end

#Beautiful ASCII greeting ^.^
def greet
  puts "
 _______  ___   _______  _______  _______  _______  _______  _______  _______ 
|       ||   | |       ||       ||   _   ||       ||       ||       ||       |
|_     _||   | |       ||_     _||  |_|  ||       ||_     _||   _   ||    ___|
  |   |  |   | |       |  |   |  |       ||       |  |   |  |  | |  ||   |___ 
  |   |  |   | |      _|  |   |  |       ||      _|  |   |  |  |_|  ||    ___|
  |   |  |   | |     |_   |   |  |   _   ||     |_   |   |  |       ||   |___ 
  |___|  |___| |_______|  |___|  |__| |__||_______|  |___|  |_______||_______|".force_encoding("US-ASCII")

  puts "\n \n \n \n"   
end

#Randomly choose a player to go first
def choose_player
  players = ['X', 'O']
  @current_player = players[rand(2)]
  puts "#{@current_player} goes first."
end

end #end class Play
#-------------------------

#Call functions
game = Play.new(@current_player)
while game.play_game?
  game.greet
  game.choose_player
  game.display_board()
  puts
  while not game.board_full?() and not game.winner?()
    game.prompt_move(@current_player)
   @current_player = game.get_next_turn()
    game.display_board
    game.call_game
    puts
  end
  game.play_game?
end










        


