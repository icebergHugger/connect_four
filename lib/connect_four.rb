class Column
  #array with 6 empty spaces#
  
end

class ConnectFour
  
  def initialize
    @@row = create_board
    create_players
  end

  
  def create_board
    #ARRAY [7 Column Arrays]#  
    row = []
    7.times do |i|
      col = [] 
      6.times {col << "  "}
      row << col
    end
    
    return row
  end
  
  def create_players
  
    players = []
    
    puts "Player 1:"
    player_1 = Hash.new
    player_1[:name] = gets.chomp
    player_1[:symbol] = "\u{1F534}"
    players << player_1
    
    puts "Player 2:"
    player_2 = Hash.new
    player_2[:name] = gets.chomp
    player_2[:symbol] = "\u{1F7E1}"
    players << player_2
    
    puts "----------"
    
    players.each do |player|
      puts "#{player[:name]} is #{player[:symbol]}"
      puts ""
    end
    
    controller(0, players)
  end
  
  def controller(num, players)
  
    get_input(players[num])
    
    display_board
    
    if !check_win(players[num][:symbol])
      if num == 1
        num = 0
      else
        num = 1
      end
      controller(num, players)
    else
      puts "#{players[num][:name]} won the game!"
    end
  end
  
  def get_input(player)
    puts "#{player[:name]} choose a column between 1 and 7:"
    column = gets.chomp.to_i
    if (1..7).include?(column)
    	new_drop(column, player)
    else
    	get_input(player)
    end
  end
  
  def new_drop(column, player)
    if !@@row[column - 1].include?("  ")
      puts "Column full!"
      get_input(player)
    end
    @@row[column - 1].to_enum.with_index.reverse_each do |x, i|
    	if x == "  "
    	  @@row[column - 1][i] = "#{player[:symbol]}"
    	  return
    	end
    end
  end
  
  def display_board()
    6.times do |i|
      @@row.each do |column|
        print "|#{column[i]}"
      end
      print "|"
      puts ""
    end
  end
  
  def check_win(symbol)
  
    matches = 0 
    side_matches = 0 
    6.times do |i|
      @@row.each do |column|
        return true if side_matches == 4
      	if column[i - 1] == "#{symbol}"
      	  side_matches += 1
      	else
      	  side_matches = 0
      	end
      end
      side_matches = 0
    end
    
    @@row.each do |column| 
      return true if matches == 4
    	column.each do |item|
    	  return if matches == 4
    	  if item == "#{symbol}"
    	    matches += 1
    	  else
    	    matches = 0
    	  end
    	end
    end
    
    return false
    
  end
end


connect_four = ConnectFour.new



