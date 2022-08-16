# frozen_string_literal: true

# require_relative 'rcchess_figures.rb'

# main class for chess console game
class ChessGame
  require_relative 'rcchess_figures'
  attr_reader :turn

  def initialize    
    make_board
    @player = 'white'
    @turn = 1
  end
  
  def make_board
    @board = Array.new(8) { Array.new(8, nil) }

    @board[0][0] = Rook.new('black')
    @board[0][1] = Knight.new('black')
    @board[0][2] = Bishop.new('black')
    @board[0][3] = Queen.new('black')
    @board[0][4] = King.new('black')
    @board[0][5] = Bishop.new('black')
    @board[0][6] = Knight.new('black')
    @board[0][7] = Rook.new('black')
    @board[1].map! { Pawn.new('black') }

    @board[7][0] = Rook.new('white')
    @board[7][1] = Knight.new('white')
    @board[7][2] = Bishop.new('white')
    @board[7][3] = Queen.new('white')
    @board[7][4] = King.new('white')
    @board[7][5] = Bishop.new('white')
    @board[7][6] = Knight.new('white')
    @board[7][7] = Rook.new('white')
    @board[6].map! { Pawn.new('white') }
  end

  def draw_board(highlight = nil)
    (system 'clear') || (system 'cls')
    $stdout.sync = true
    row_c = 8
    # white = true
    puts @player.upcase+ " TURN"    
    puts
    puts '     a   b   c   d   e   f   g   h'
    puts '   ╔═══╦═══╦═══╦═══╦═══╦═══╦═══╦═══╗'
    (0..7).each do |r|
      print " " + row_c.to_s+' ║'
      (0..7).each do |c|
        @board[r][c] == nil ? sign=' ' : sign = @board[r][c].icon
        # bcolor="\e[43m" if white == true
        # bcolor="\e[46m" if white == false
        # bcolor="\e[42m" if highlight && highlight.include?([r,c])
        # print " " + bcolor +sign+ "\e[0m" + " ║"
        if highlight && highlight.include?([r,c])
          print "\e[42m " +sign+ "\e[0m" + " ║"
        else
          print " " + sign + " ║"
        end
        # white = !white
      end
      print " "+row_c.to_s
      puts
      puts '   ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣' unless row_c == 1
      row_c -= 1
    end
    puts '   ╚═══╩═══╩═══╩═══╩═══╩═══╩═══╩═══╝'
    puts '     a   b   c   d   e   f   g   h'
    puts
  end

  def save
    require 'json'
    out_data = [@player, @turn, Marshal.dump(@board)].to_json
    File.open('save.json', 'w') { |file| file.write(out_data) }
    puts 'Game saved.'
    gets
  end

  def load
    require 'json'
    game_data = JSON.parse File.read('save.json')
    @player = game_data[0]
    @turn = game_data[1]
    @board = Marshal.load(game_data[2])
    puts 'Game loaded.'
    gets
  end

  def check_input
    choice = gets.chomp
    if choice == 'S'
      save
    else
      transform_coordinates(choice)
    end
  end

  def highlight_board_move(player)
    possible_to_move = []
    (0..7).each do |r|
      (0..7).each do |c|
        possible_to_move.push([r, c]) if @board[r][c] && @board[r][c].color == player
      end
    end
    possible_to_move
  end

  def highlight_figure_moves(coords)
    possible_move = @board[coords[0]][coords[1]].move(coords, @board, @turn)
    check_move = []
    # check for self check
    possible_move.each { |move|
      temp_board = Marshal.load(Marshal.dump(@board))
      # move figure on temp board
      temp_board[move[0]][move[1]] = temp_board[coords[0]][coords[1]]
      temp_board[coords[0]][coords[1]] = nil
      if @chkchk
        check_move.push(move) if check_check(temp_board, @chkchk)
      else
        check_move.push(move) if check_check(temp_board, @player)
      end
      }
    possible_move.difference(check_move)
  end

  def check_check(board, color)
    # find king and opposing figures
    enemy_pos = []
    (0..7).each do |x|
      (0..7).each do |y|
        #p x,y
        #p board[x][y]
        @king_pos = [x,y] if board[x][y] && board[x][y].type=='king' && board[x][y].color == color
        enemy_pos.push([x, y]) if board[x][y] != nil && board[x][y].color != color
      end
    end
    # p enemy_pos
    # check threat for chosen king
    enemy_pos.each do |coords|
      enemy_moves = board[coords[0]][coords[1]].threat(coords, board)
      # if board[coords[0]][coords[1]].type=='queen'
      # p board[coords[0]][coords[1]]
      # p "e moves",enemy_moves
      # p @king_pos
      # gets
      # end
      return true if enemy_moves.include?(@king_pos)
    end
    false
  end

  def move(player)
    puts "It's " + player + "'s turn."
    # check which figures can be moved
    allowed_moves = highlight_board_move(player)
    draw_board(allowed_moves)
    loop do
      puts 'Allowed ' +player+' figures have green background.'
      puts 'Please choose one by typing a row(letter) and column(number), eg. a1. Type S to save or Q to quit.'      
      @coords_old = check_input
      unless allowed_moves.include?(@coords_old)
        puts 'You do not have a figure there! Please choose a valid figure!'
        next
      end
      # following line added to allow checking of current figure in case of king movement, otherwise inifnite recursion can result from threat checks
      # @current_figure = @board[@coords_old[0]][@coords_old[1]]
      @allowed_moves_figure = highlight_figure_moves(@coords_old)
      if @allowed_moves_figure == []
        puts 'This figure cannot move! Please choose a valid figure!'
        next
      end
      break
    end
    # check allowed moves for chosen figure
    draw_board(@allowed_moves_figure)
    loop do
      puts 'Allowed moves have green background.'
      puts 'Please choose one by typing a row(letter) and column(number). eg. a1. Type S to save or Q to quit.'
      @coords_new = check_input
      break if @allowed_moves_figure.include?(@coords_new)
      puts 'This is not a legal move! Please choose a legal move'
    end
    # move figure
    # before move check passant flag
    check_set_passant(@coords_old,@coords_new)
    @board[@coords_new[0]][@coords_new[1]] = @board[@coords_old[0]][@coords_old[1]]
    @board[@coords_old[0]][@coords_old[1]] = nil
    # after move check for passant
    check_passant(@coords_new[0],@coords_new[1])
    # check promotion
    check_promotion
    # check castling
    check_castling(@coords_old,@coords_new)
    # check_check
    if @player=='white'
      check_check(@board,'black') ? @chkchk='black' : @chkchk=false
    else
      check_check(@board,'white') ? @chkchk='white' : @chkchk=false
    end    
    if @chkchk
      puts @chkchk+" has been checked!"
      gets
      @chkmoves = highlight_board_move(@chkchk)
      @allowed_chkmoves=[]
      @chkmoves.each { |move|
        @allowed_chkmoves.push( highlight_figure_moves(move))
        }
      if @allowed_chkmoves.select{|elem| !elem.empty?}.empty?
        puts "CHECK MATE!"
        gets
        return @chkchk
      end
    end
    return "game on"
  end

  def transform_coordinates(input)
    case input[0]
    when 'a'
      column = 0
    when 'b'
      column  = 1
    when 'c'
      column  = 2
    when 'd'
      column  = 3
    when 'e'
      column  = 4
    when 'f'
      column  = 5
    when 'g'
      column  = 6
    when 'h'
      column  = 7
    end
    row = (input[1].to_i - 8).abs
    [row, column]
  end

  def check_promotion
    # check pawn promotion (makes it to 8th rank)
    (0..7).each do |x|
      @board[0][x] = Queen.new('white') if @board[0][x] && @board[0][x].color == 'white' && @board[0][x].type == 'pawn'
      @board[7][x] = Queen.new('black') if @board[7][x] && @board[7][x].color == 'black' && @board[7][x].type == 'pawn'
    end
  end

  def check_set_passant(old,nnew)    
    if @board[old[0]][old[1]] && @board[old[0]][old[1]].type == 'pawn' && (old[0]+2==nnew[0] || old[0]-2==nnew[0])
      @board[old[0]][old[1]].passant = @turn
    end
  end

  def check_passant(x,y)
    if @board[x][y].type == 'pawn'&& @board[x][y].color == 'white'
      if @board[x+1][y] && @board[x+1][y].type == 'pawn'&& @board[x+1][y].color == 'black' && @board[x+1][y].passant == (@turn.to_i-1)
        @board[x+1][y]=nil
      end
    elsif @board[x][y].type == 'pawn'&& @board[x][y].color == 'black'
      if @board[x-1][y] && @board[x-1][y].type == 'pawn'&& @board[x-1][y].color == 'black' && @board[x-1][y].passant == (@turn.to_i-1)
        @board[x-1][y]=nil
      end
    end
  end

  def check_castling(nnew,old)
    #p old
    #p nnew
    #p @board[old[0]][old[1]]
    #p @board[old[0]][0]
    #gets
    if @board[old[0]][old[1]] && @board[old[0]][old[1]].type == 'king' && old[1]+2==nnew[1]
      @board[old[0]][old[1]].castle=false
      @board[old[0]][0].castle=false
      @board[old[0]][3]=@board[old[0]][0]
      @board[old[0]][0]=nil
    elsif @board[old[0]][old[1]] && @board[old[0]][old[1]].type == 'king' &&  old[1]-2==nnew[1]
      @board[old[0]][old[1]].castle=false
      @board[old[0]][7].castle=false
      #p @board[old[0]][3],@board[old[0]][0]
      @board[old[0]][5]=@board[old[0]][7]
      @board[old[0]][7]=nil
    end
  end
 
  def play
    (system 'clear') || (system 'cls')
    puts '                  ╔═══════════════╗'
    puts '                  ║ AWESOME CHESS ║'
    puts '                  ╚═══════════════╝'
    puts
    puts '                      Welcome!'
    puts
    puts 'Would you like to (L)oad the old game or (S)tart a new one?'
    puts
    puts 'Enter L / S'
    puts
    choice = gets.chomp.upcase
    loop do
      if choice == 'S'
        break
      elsif choice == 'L'
        load()
        break
      else
        puts 'Not a valid choice.'
      end
    end
    loop do
      if move(@player)=='game on'
        @player == 'white'? @player='black' : @player='white'
        @turn+=1
      else
        puts "GAME OVER!"
      end
    end
  end
end

# testing
game = ChessGame.new
# game.make_board
# game.draw_board
# puts
# game.move("white")
game.play
