class DrunkardCardGame
  RANKS = %w[2 3 4 5 6 7 8 9 T J Q K A]
  SUITS = %w[c d h s]
  DECK = RANKS.product(SUITS).map(&:join)
  @@step_number = 0

  def initialize(options = {})
    @decks = options.fetch(:decks, 1)
    @players = options.fetch(:players, 2)
  end

  def shuffle
    @playing_deck = (DECK*@decks).shuffle
  end

  def deal(cards= (DECK*@decks).length/@players)
    shuffle
    @dealt = Array.new(@players) { Array.new }
    @dealt.map { |hand| cards.times { hand << @playing_deck.pop } }
    print 'Deal completed!' + '    ' + "Cards used: #{@dealt.flatten.size};" + '    '\
          + "Cards remaining: #{@playing_deck.size};\n"
    puts 'Primary card distribution is:'
    display
  end

  def play
    deal
    puts 'The game starts! Enter q/quit/exit to quit or press any another key to go into next step.'
    while true
      input = gets.chomp
      if (input == 'q') | (input == 'quit') | (input == 'exit')
        break
      else
        puts "Step number #{@@step_number+=1}"
        bet = @dealt.map { |col| col.delete_at(0) } # кожен гравець скинувся по верхній карті з своєї колоди.
        card_priority = [] #визначаємо старшинство карт.
        (0...@players).each { |i|
          card_priority << RANKS.index(bet[i][0])
        }
        max_elements = {0 => card_priority[0]} #player_numb => value
        (1...card_priority.length).each { |i|
          if card_priority[i]>max_elements.values[0]
            max_elements.clear
            max_elements = {i => card_priority[i]}
          elsif card_priority[i] == max_elements.values[0]
            max_elements[i] = card_priority[i]
          end
        }
        if max_elements.count > 1
          #якщо у двох гравців однакові по рангу карти, будемо порівнювати масті ( в порядку запису їх в множину)
          suits_elements = {} #старшинство мастей карт. player =>value_at_suits
          max_elements.keys.each { |key|
            suits_elements[key] = SUITS.index(bet[key][1])
          }
          winner = suits_elements.key(suits_elements.values.max)
        else
          winner = max_elements.keys[0]
        end
        bet.each { |item| @dealt[winner]<<item }
        puts "Player #{winner+1} wins round #{@@step_number}!"
        #puts @dealt[0].join(' | ')
        @dealt.delete([])
        display
      end
    end
  end

  def display
    @dealt.each_with_index { |cards, i| puts "Player #{i+1}: #{cards.join(' | ')}" }
  end

  def show_deck
    puts DECK.join(' | ')
  end

  private :shuffle
end

game = DrunkardCardGame.new(decks: 1, players: 4)
game.play
