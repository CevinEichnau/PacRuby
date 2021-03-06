require "./init.rb"
require 'io/console'


def read_char
  STDIN.echo = false
  STDIN.raw!


  input = STDIN.getc.chr
    if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
  ensure
  STDIN.echo = true
  STDIN.cooked!
 
  return input
end


def run
 



  player = Player.new
  f = Gamefield.new
  f.player = player
  player.gamefield = f

   f.read_file




  puts "Enter a Player name"
  name = gets.chomp


  player.player_name(name)

  puts "Hello #{player.name}, you have #{player.live.to_s} live.\n"
  puts "Press Arrow up, down, left or right for start "

 

  e=Enemy.new
  e2=Enemy.new
  e.gamefield = f
  e2.gamefield = f


  i = Item.create_item(:coin)
  u = Item.create_item(:diamond)
  s = Item.create_item(:emerald)
  
  f.set_at(6, 5, player)
  f.set_at(0, 8, e)
  f.set_at(7, 0, e2)
  f.set_at(9, 12, i)
  f.set_at(0, 16, u)
  f.set_at(19, 18, s)


  
  puts f.to_string
  #f.think

  def on_game_loop(f, player, e, e2)
    c = read_char
    x = 0
    y = 0


    case c
    when "\e[B" # go down
      if player.y  < f.size-1 
        y = 1
      end
    when "\e[C" # go right
      if player.x < f.size-1
        x = 1
      end
    when "\e[D" # go left
      if player.x  > 0
        x = -1
      end
    when "\e[A" # go up
      if player.y  > 0
        y = -1
      end
    when "\e"
      system("clear")
      exit 0
    else
      puts "SOMETHING ELSE: #{c.inspect}"
    end

    # update the player movement !!!
    f.move_object(x, y, player) do |old|
      f.check_movement(player, old)
    end

    # let the enemy update itself
    f.think

    #e.think
    #e2.think
    #f.set_at(e.x, e.y, e)

    # draw the screeen again !!!
    system('clear')
    player.drop_items
    puts "x:#{player.x} y:#{player.y}"
    puts "#{player.stats}"
    puts f.to_string

##############################################
 e_e = f.nearest_decision(e)
 e2_e = f.nearest_decision(e2)
 e3_e = f.nearest_decision(player)

 puts "ex:#{e_e.first} ey:#{e_e.last}\n"
 puts "-"*20
 puts "e2x:#{e2_e.first} e2y:#{e2_e.last}\n"
 puts "-"*20
 puts "playerx:#{e3_e.first} playery:#{e3_e.last}\n"
 ############################################
  end

  on_game_loop(f, player, e, e2) while(f.win?(player))
  puts "GAME OVER\n"
  puts "play again? y/n"
  again = gets.chomp
  if again == "y"
    run
  elsif again == "n"
    puts "Thank you for play the game by =) "
  else
    puts "invalid input game stoped now"
  end    
end
run