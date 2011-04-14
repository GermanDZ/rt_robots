SYMBOLS = { :ZERO => "0", :CROSS => "x" }

class Joya_TTT     
    attr_accessor :board

    def load_rules
        @rules = [ WinRule.new(@board),
                BlockRule.new(@board),
                PreferedMovesRule.new(@board)
            ]
    end
    
    def next_move
        load_rules
        begin
            move = @rules.shift.execute
        end until move.valid?
        move
    end
end

class Rule
    def initialize (board)
        @board = board
        @symbol = @board.next_player?
    end

    def execute
        Move.new(free(candidates))
    end

    def free(candidates)
        candidates.key(Board::FREE)
    end
    private :free
    
    def next_symbol_to_play
        @symbol
    end
end
class WinRule < Rule
    def candidates
        moves = @board.winning_moves(@symbol)
        @board.current_state(moves[0])
    end    
end

class BlockRule < WinRule
    def initialize(board)
        super board
        @symbol = other_symbol?
    end
     
    def other_symbol?
        SYMBOLS.keys.select { |symbol| symbol!=@symbol }[0]
    end
end


class PreferedMovesRule < Rule

    PREFERED_MOVES = [
        :bottom_left,
        :top_right,
        :top_left,
        :bottom_right,
        :center,
        :center_right,
        :bottom_center,
        :top_center,
        :center_left
    ]

    def candidates
        @board.current_state(PREFERED_MOVES)
    end
    
end

class Move
    attr_accessor :code

    CODES = {:top_left => 0,
        :top_center => 1,
        :top_right => 2,
        :center_left => 3,
        :center => 4,
        :center_right => 5,
        :bottom_left => 6,
        :bottom_center => 7,
        :bottom_right => 8}

    def initialize(code=:center)
        @code = code
    end
    
    def output_code
        CODES[@code]
    end
    
    def valid?
        @code!=nil
    end
end

class Board
    
    BLANK = "---------"
    FREE = "-"

    WINNERS_MOVE = [
                    [:top_left, :top_center, :top_right],
                    [:center_left, :center, :center_right],
                    [:bottom_left, :bottom_center, :bottom_right],
                    [:top_left, :center_left, :bottom_left],
                    [:top_center, :center, :bottom_center],
                    [:top_right, :center_right, :bottom_right],
                    [:top_left, :center, :bottom_right],
                    [:top_right, :center, :bottom_left]
                   ]
    
    attr_accessor :state
    
    def initialize(state)
        @state = {}
        state.split(//).each_index{|index| @state[Move::CODES.key(index)] = state[index]}
    end
    
    def next_player?
        even_free_cells? ? :ZERO : :CROSS
    end
    
    def even_free_cells?
        @state.values.select { |cell| cell==FREE }.count.modulo(2)==1
    end
    private :even_free_cells?
    
    def winning_moves(symbol)
        WINNERS_MOVE.select { |move| can_win?(move, symbol) }
    end
    
    def can_win?(move, symbol)
        current_state = current_state(move)
        count_symbols(current_state, SYMBOLS[symbol])==2 && count_symbols(current_state, FREE)==1
    end
    
    def count_symbols(move, symbol)
        move.values.select{|cell| cell==symbol}.count
    end
    private :count_symbols
    
    def current_state(desired_cells)
        current = {}
        desired_cells.each {|cell| current[cell] = @state[cell] } unless desired_cells.nil?
        current
    end
    
end
