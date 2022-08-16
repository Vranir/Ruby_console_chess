# helper functions

def check_oob?(coords)
  return true if coords[0]>=0 && coords[0]<=7 && coords[1]>=0 && coords[1]<=7
  false
end

def diagonal_movement(coords, board, my_color)  
  possible_move = []
  # check desc pos
  x = coords[0] + 1
  y = coords[1] - 1
  while x <= 7 && y >= 0
    possible_move.push([x, y]) if board[x][y] == nil
    if board[x][y] && board[x][y].color != my_color
      possible_move.push([x, y])
      break
    elsif board[x][y] && board[x][y].color == my_color
      break
    end
    x += 1
    y -= 1
  end

  # check desc neg
  x = coords[0] - 1
  y = coords[1] + 1
  while x >= 0 && y <= 7
    possible_move.push([x, y]) if board[x][y] == nil
    if board[x][y] && board[x][y].color != my_color
      possible_move.push([x, y])
      break
    elsif board[x][y] && board[x][y].color == my_color
      break
    end
    x -= 1
    y += 1
  end

  # check asc pos
  x = coords[0] + 1
  y = coords[1] + 1
  while x <= 7 && y <= 7
    possible_move.push([x, y]) if board[x][y] == nil
    if board[x][y] && board[x][y].color != my_color
      possible_move.push([x, y])
      break
    elsif board[x][y] && board[x][y].color == my_color
      break
    end
    x += 1
    y += 1
  end

  # check asc neg
  x = coords[0] - 1
  y = coords[1] - 1  
  while x >= 0 && y >= 0    
    possible_move.push([x, y]) if board[x][y] == nil
    if board[x][y] && board[x][y].color != my_color
      possible_move.push([x, y])
      break
    elsif board[x][y] && board[x][y].color == my_color
      break
    end
    x -= 1
    y -= 1
  end
  possible_move
end

def diagonal_threat(coords, board, my_color)
  possible_move = []
  # check desc pos
  x = coords[0] + 1
  y = coords[1] - 1
  while x <= 7 && y >= 0
    possible_move.push([x, y]) if board[x][y] == nil
    if board[x][y] != nil
      possible_move.push([x, y])
      break
    end
    x += 1
    y -= 1
  end

  # check desc neg
  x = coords[0] - 1
  y = coords[1] + 1
  while x >= 0 && y <= 7
    possible_move.push([x, y]) if board[x][y] == nil
    if board[x][y] != nil
      possible_move.push([x, y])
      break
    end
    x -= 1
    y += 1
  end

  # check asc pos
  x = coords[0] + 1
  y = coords[1] + 1
  while x <= 7 && y <= 7
    possible_move.push([x, y]) if board[x][y] == nil
    if board[x][y] != nil
      possible_move.push([x, y])
      break
    end
    x += 1
    y += 1
  end

  # check asc neg
  x = coords[0] - 1
  y = coords[1] - 1  
  while x >= 0 && y >= 0    
    possible_move.push([x, y]) if board[x][y] == nil
    if board[x][y] != nil
      possible_move.push([x, y])
      break
    end
    x -= 1
    y -= 1
  end
  possible_move
end

def horizontal_vertical_movement(coords, board, my_color)  
  possible_move=[]
  # check vertiacl pos
  x = coords[0] + 1
  while x <= 7
    possible_move.push([x, coords[1]]) if board[x][coords[1]] == nil
    if board[x][coords[1]] && board[x][coords[1]].color != my_color
      possible_move.push([x, coords[1]])
      break
    elsif board[x][coords[1]] && board[x][coords[1]].color == my_color
      break
    end
    x += 1
  end
  # check vertical neg
  x = coords[0] - 1
  while x >= 0
    possible_move.push([x, coords[1]]) if board[x][coords[1]] == nil
    if board[x][coords[1]] && board[x][coords[1]].color != my_color
      possible_move.push([x, coords[1]])
      break
    elsif board[x][coords[1]] && board[x][coords[1]].color == my_color
      break
    end
    x -= 1
  end
  # check horizontal pos
  x = coords[1] + 1
  while x <= 7
    possible_move.push([coords[0], x]) if board[coords[0]][x] == nil
    if board[coords[0]][x] && board[coords[0]][x].color != my_color
      possible_move.push([coords[0], x])
      break
    elsif board[coords[0]][x] && board[coords[0]][x].color == my_color
      break
    end
    x += 1
  end
  # check horizontal neg
  x = coords[1] - 1
  while x >= 0
    possible_move.push([coords[0], x]) if board[coords[0]][x] == nil
    if board[coords[0]][x] && board[coords[0]][x].color != my_color
      possible_move.push([coords[0], x])
      break
    elsif board[coords[0]][x] && board[coords[0]][x].color == my_color
      break
    end
    x -= 1
  end
  possible_move
end

def horizontal_vertical_threat(coords, board, my_color)  
  possible_move = []
  
  # check vertical pos
  x = coords[0] + 1
  while x <= 7
    possible_move.push([x, coords[1]]) if board[x][coords[1]] == nil
    if board[x][coords[1]] != nil
      possible_move.push([x, coords[1]])
      break
    end
    x += 1
  end
  # check vertical neg
  x = coords[0] - 1
  while x >= 0
    possible_move.push([x, coords[1]]) if board[x][coords[1]] == nil
    if board[x][coords[1]] != nil
      possible_move.push([x, coords[1]])
      break
    end
    x -= 1
  end
  
  # check horizontal pos
  x = coords[1] + 1
  while x <= 7
    possible_move.push([coords[0], x]) if board[coords[0]][x] == nil
    if board[coords[0]][x] != nil
      possible_move.push([coords[0],x])
      break
    end
    x += 1
  end
  # check horizontal neg
  x=coords[1] - 1
  while x >= 0
    possible_move.push([coords[0], x]) if board[coords[0]][x] == nil
    if board[coords[0]][x] != nil
      possible_move.push([coords[0],x])
      break
    end
    x -= 1
  end
  #p board[coords[0]][coords[1]]
  #p coords
  #p possible_move
  #gets
  possible_move
end

def check_threat(candidates, board, my_color, my_pos)
  # collect all enemy positions
  enemy_pos=[]
  (0..7).each do |x|
    (0..7).each do |y|
      if board[x][y] != nil && board[x][y].color != my_color
        enemy_pos.push([x, y])
      end
    end
  end
  #check threat for all enemies for all candidates
  enemy_pos.each do |coords|
    enemy_moves = board[coords[0]][coords[1]].threat(coords, board)
    candidates = candidates - enemy_moves    
  end
  candidates
end

# chess game pawn
class Pawn
  attr_reader :color, :icon, :type, :coords, :passant
  attr_writer :passant

  def initialize(color)
    @type = 'pawn'
    @color = color
    @color == 'white' ? @icon = '♙' : @icon = '♟'
    @passant = nil
  end

  def move(coords,board,turn)
    possible_move=[]    
    if @color == 'black'      
      possible_move.push([coords[0] + 1, coords[1]]) if board[coords[0] +1 ][coords[1]] == nil
      possible_move.push([coords[0] + 1, coords[1] + 1]) if board[coords[0] + 1][coords[1] + 1]!=nil && board[coords[0] + 1][coords[1]+1].color != @color
      possible_move.push([coords[0] + 1, coords[1] - 1]) if board[coords[0] + 1][coords[1] - 1]!=nil && board[coords[0]+ 1][coords[1]-1].color != @color
      possible_move.push([3, coords[1]]) if coords[0] == 1 && board[2][coords[1]] == nil && board[3][coords[1]] == nil
      # en passant move below      
      possible_move.push([coords[0] + 1, coords[1] + 1]) if board[coords[0]][coords[1] + 1]!=nil && board[coords[0]][coords[1]+1].color != @color && board[coords[0]][coords[1]+1].type == 'pawn' && board[coords[0]][coords[1]+1].passant == (turn.to_i-1)
      possible_move.push([coords[0] + 1, coords[1] - 1]) if board[coords[0]][coords[1] - 1]!=nil && board[coords[0]][coords[1]-1].color != @color && board[coords[0]][coords[1]-1].type == 'pawn' && board[coords[0]][coords[1]-1].passant == (turn.to_i-1)
    else
      possible_move.push([coords[0]-1,coords[1]]) if board[coords[0]-1][coords[1]] == nil
      possible_move.push([coords[0]-1,coords[1]+1]) if board[coords[0]-1][coords[1]+1] != nil && board[coords[0]-1][coords[1]+1].color != @color
      possible_move.push([coords[0]-1,coords[1]-1]) if board[coords[0]-1][coords[1]-1] != nil && board[coords[0]-1][coords[1]-1].color != @color
      possible_move.push([4,coords[1]]) if coords[0] == 6 && board[4][coords[1]] == nil && board[5][coords[1]] == nil
      # en passant move below      
      possible_move.push([coords[0] - 1, coords[1] + 1]) if board[coords[0]][coords[1] + 1]!=nil && board[coords[0]][coords[1]+1].color != @color && board[coords[0]][coords[1]+1].type == 'pawn' && board[coords[0]][coords[1]+1].passant == (turn.to_i-1)
      possible_move.push([coords[0] - 1, coords[1] - 1]) if board[coords[0]][coords[1] - 1]!=nil && board[coords[0]][coords[1]-1].color != @color && board[coords[0]][coords[1]-1].type == 'pawn' && board[coords[0]][coords[1]-1].passant == (turn.to_i-1)
    end
    possible_move
  end

  def threat(coords,board)
    possible_move = []
    if @color == 'black'
      possible_move.push([coords[0] + 1, coords[1] + 1])
      possible_move.push([coords[0] + 1, coords[1] - 1])
    else
      possible_move.push([coords[0] - 1, coords[1] + 1])
      possible_move.push([coords[0] - 1, coords[1] - 1])
    end
    possible_move
  end
end

# chess game king
class King
  attr_reader :color, :icon, :type, :coords, :castle
  attr_writer :castle

  def initialize(color)
    @type = 'king'
    @color = color
    @color == 'white' ? @icon = '♔' : @icon = '♚'
    @castle = true
  end

  def check_castle(board)
    def check_castle_no_threat(board, color, pos)
      # find opposing figures
      enemy_pos = []
      (0..7).each do |x|
        (0..7).each do |y|
          #p x,y
          #p board[x][y]          
          enemy_pos.push([x, y]) if board[x][y] != nil && board[x][y].color != color
        end
      end
      # p enemy_pos
      # check threat for chosen pos
      enemy_pos.each do |coords|
        enemy_moves = board[coords[0]][coords[1]].threat(coords, board)
        # p "e moves",enemy_moves
        # p king_pos
        # gets
        return false if enemy_moves.include?(pos)
      end
      true
    end

    possible_castle=[]
    #p @color
    #p @castle
    #gets
    if @color=='white' && @castle==true
      possible_castle.push([7,2]) if board[7][7] && board[7][7].type=='rook' && board[7][7].castle==true && board[7][3..6].all?(nil) && check_castle_no_threat(board,'white',[7,4])
      possible_castle.push([7,6]) if board[7][0] && board[7][0].type=='rook' && board[7][0].castle==true && board[7][5..6].all?(nil) && check_castle_no_threat(board,'white',[7,4])
    elsif @color=='black' && @castle==true
      possible_castle.push([0,2]) if board[0][0] && board[0][0].type=='rook' && board[0][0].castle==true && board[0][3..6].all?(nil) && check_castle_no_threat(board,'black',[0,4])
      possible_castle.push([0,6]) if board[0][7] && board[0][7].type=='rook' && board[0][7].castle==true && board[0][5..6].all?(nil) && check_castle_no_threat(board,'black',[0,4])
    end    
    possible_castle
  end

  def move(coords,board,turn)
    x = coords[0]
    y = coords[1]

    # create array of all possible moves for king
    move_candidate = [[x + 1, y],
                      [x + 1, y + 1],
                      [x + 1, y - 1],
                      [x, y + 1],
                      [x, y - 1],
                      [x - 1, y],
                      [x - 1, y + 1],
                      [x - 1, y - 1]]
    # purge out of bounds
    move_candidate.select! { |candidate| candidate[0] >= 0 && candidate[0] <= 7 && candidate[1] >= 0 && candidate[1] <= 7 }
    # purge friendlies
    move_candidate.select! { |candidate| board[candidate[0]][candidate[1]] == nil || board[candidate[0]][candidate[1]].color != @color}
    # puruge threatened
    possible_move = check_threat(move_candidate, board, @color, coords)
    #check castelings
    castle=self.check_castle(board)
    possible_move=possible_move+castle if castle!=[]
    # done
    possible_move
  end
  def threat(coords,board)
    x = coords[0]
    y = coords[1]

    # create array of all possible moves for king
    move_candidate = [[x + 1, y],
                      [x + 1, y + 1],
                      [x + 1, y - 1],
                      [x, y + 1],
                      [x, y - 1],
                      [x - 1, y],
                      [x - 1, y + 1],
                      [x - 1, y - 1]]
    # purge out of bounds
    move_candidate.select! { |candidate| candidate[0] >= 0 && candidate[0] <= 7 && candidate[1] >= 0 && candidate[1] <= 7 }
    # done
    move_candidate
  end
end

# chess game queen
class Queen
  attr_reader :color, :icon, :type, :coords

  def initialize(color)
    @type = 'queen'
    @color = color
    @color == 'white' ? @icon = '♕' : @icon = '♛'
  end

  def move(coords, board,turn)
    possible_move = horizontal_vertical_movement(coords,board,@color) + diagonal_movement(coords,board,@color)
    possible_move
  end

  def threat(coords, board)
    possible_move = horizontal_vertical_threat(coords,board,@color) + diagonal_threat(coords,board,@color)
    possible_move
  end
end

# chess game rook
class Rook
  attr_reader :color, :icon, :type, :coords, :castle
  attr_writer :castle

  def initialize(color)
    @type = 'rook'
    @color = color
    @color == 'white' ? @icon = '♖' : @icon = '♜'
    @castle = true
  end

  def move(coords,board,turn)
    possible_move = horizontal_vertical_movement(coords,board,@color)
    possible_move
  end

  def threat(coords,board)
    possible_move = horizontal_vertical_threat(coords,board,@color)
    possible_move
  end
end

# chess game bishop
class Bishop
  attr_reader :color, :icon, :type, :coords

  def initialize(color)
    @type = 'bishop'
    @color = color
    @color == 'white' ? @icon = '♗' : @icon = '♝'    
  end

  def move(coords,board,turn)
    possible_move = diagonal_movement(coords, board, @color)
    possible_move
  end

  def threat(coords,board)
    possible_move = diagonal_threat(coords,board,@color)
    possible_move
  end
end

# chess game knight
class Knight
  attr_reader :color, :icon, :type, :coords

  def initialize(color)
    @type = 'knight'
    @color = color
    @color == 'white' ? @icon = '♘' : @icon = '♞'
  end

  def move(coords, board,turn)
    possible_move=[]
    [1, 2, -1, -2].each do |x|
      [1, 2, -1, -2].each do |y|
        coord_attempt = [coords[0]+x,coords[1]+y]
        next if x.abs == y.abs || check_oob?(coord_attempt) != true 
        if board[coord_attempt[0]][coord_attempt[1]] == nil || board[coord_attempt[0]][coord_attempt[1]].color != @color
          possible_move.push(coord_attempt)
        end
      end
    end
    possible_move
  end

  def threat(coords, board)
    possible_move = []
    [1, 2, -1, -2].each do |x|
      [1, 2, -1, -2].each do |y|
        coord_attempt = [coords[0] + x, coords[1] + y]
        next if x.abs == y.abs || check_oob?(coord_attempt) != true
        possible_move.push(coord_attempt)
      end
    end
    possible_move
  end
end
