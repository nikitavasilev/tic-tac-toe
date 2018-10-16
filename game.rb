require_relative 'board'
require_relative 'player'
require 'colorize'

class Game
  def initialize
    puts "What's the name of the first player?"
    print "> "
    name_player_1 = gets.chomp
    puts "#{name_player_1} you got the X's."
    player_color_1 = "X"
    @player_1 = Player.new(name_player_1, player_color_1)
    puts "What's the name of the second player?"
    print "> "
    name_player_2 = gets.chomp
    puts "#{name_player_2} you got the O's."
    player_color_2 = "O"
    @player_2 = Player.new(name_player_2, player_color_2)
    @players = [@player_1, @player_2]
    @object_board = Board.new
  end

  def go
    puts "\n=================> RULES <================="
    puts "\nTic-tac-toe (also known as noughts and"
    puts "crosses or Xs and Os) is a paper-and-pencil"
    puts "game for two players, X and O, who take"
    puts "turns marking the spaces in a 3×3 grid."
    puts "The player who succeeds in placing three"
    puts "of their marks in a horizontal,"
    puts "vertical, or diagonal row wins the game.\n\n"
    puts "==========================================="
    puts "               LET'S PLAY!"
    puts "==========================================="
    self.turn
  end

  def turn
      turns = 0
    while @object_board.victory? == false do # Tant que les conditions de la victoire ne sont pas atteintes
      @players.each{ |player| # On itère sur chaque joueur placé dans l'array @players
        @object_board.display_board # On affiche le tableau
        puts "================= TURN #{turns + 1} =================" # On affiche le tour en question
        puts "#{player.name}! Where do you wanna put your mark?"   # On demande une case à l'utilisateur
        puts "Give a value between 1 & 9 :"
        print "> "
        n = gets.chomp.to_i   # On enregistre la case dans la variable n
         # On lui retire 1 pour qu'elle correspondent à un index
          until n > 0 && n < 10 # On accepte que de 1 à 9
            puts "Wrong number given, try again:"
            print '> '
            n = gets.chomp.to_i
          end
          n = n - 1 # On retire 1 pour que ça corresponde à l'index (sans ça on commence à 0 et pas à 1)
        @info_player = [player.name, player.player_color, n]
        @object_board.play(@info_player)
        #puts @object_board.victory?

        if @object_board.victory?
          @object_board.display_board
          puts "\n==========================================="
          puts "     Congrats #{player.name}, you won"
          puts "==========================================="
          puts "Wanna play again? (Y/n)"
          print "> "
          answer = gets.chomp.upcase
          if answer == "Y"
            Game.new.go
          else
            puts "Bye!"
          end
          break # on sort de la boucle each si c'est le joueur a gagné.
        end

      turns += 1 # On incrémente turns ici

      if turns == 9 # on sort de la boucle each si turns arrive à 9 et on annonce le draw.
        @object_board.display_board
        puts "==========================================="
        puts "                It's a draw :("
        puts "===========================================\n\n"
        puts "Wanna play again? (Y/n)"
        print "> "
        answer = gets.chomp.upcase
        if answer == "Y"
          Game.new.go
        else
          puts "See you!"
        end
        break
      end
      }
    end #Fin de la boucle while
  end
end

Game.new.go