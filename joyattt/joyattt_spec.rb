require "./joyattt"

describe Joya_TTT do

    before(:each) do
        @joya_ttt = Joya_TTT.new
    end
    
    it "should play with the correct symbol" do
        board = Board.new(Board::BLANK)
        rule = Rule.new(board)
        rule.next_symbol_to_play.should eq(:ZERO)
        
        board = Board.new("----0----")
        rule = Rule.new(board)
        rule.next_symbol_to_play.should eq(:CROSS)
        
        board = Board.new("----0---x")
        rule = Rule.new(board)
        rule.next_symbol_to_play.should eq(:ZERO)
    end
    
    it "should make the first move when board is empty" do
        @joya_ttt.board = Board.new(Board::BLANK)
        @joya_ttt.next_move.code.should eq(:bottom_left)
    end

    it "should play to win when is possible" do
        @joya_ttt.board = Board.new("00-xx----")
        @joya_ttt.next_move.code.should eq(:top_right)
        @joya_ttt.board = Board.new("--0-0--xx")
        @joya_ttt.next_move.code.should eq(:bottom_left)
        @joya_ttt.board = Board.new("--0x-0x0-")
        @joya_ttt.next_move.code.should eq(:top_left)
    end
    
    it "should block to when is possible" do
        @joya_ttt.board = Board.new("0--xx--0-")
        @joya_ttt.next_move.code.should eq(:center_right)
        @joya_ttt.board = Board.new("00-x---0x")
        @joya_ttt.next_move.code.should eq(:top_right)
    end

    it "should play any free position" do
        @joya_ttt.board = Board.new("---------")
        @joya_ttt.next_move.code.should eq(:bottom_left)
        @joya_ttt.board = Board.new("--------0")
        @joya_ttt.next_move.code.should eq(:bottom_left)
        @joya_ttt.board = Board.new("----0----")
        @joya_ttt.next_move.code.should eq(:bottom_left)
        @joya_ttt.board = Board.new("----0---x")
        @joya_ttt.next_move.code.should eq(:bottom_left)
    end    
end

describe Board do

    it "should inform the winners moves" do
        Board::WINNERS_MOVE.should include([:top_left, :center_left, :bottom_left])
    end
    
    it "should inform the current state for a movement" do
        @board = Board.new("00-xx----")
        @board.current_state([:top_left, :center_left, :bottom_left]).should eq( { :top_left => SYMBOLS[:ZERO],
                                                                                                     :center_left => SYMBOLS[:CROSS],
                                                                                                     :bottom_left => Board::FREE } )
    end

    it "should inform the available movements for 0 to win" do
        @board = Board.new("0--x0x---")
        @board.winning_moves(:ZERO).should include ([:top_left, :center, :bottom_right])
        @board = Board.new("00-xx----")
        @board.winning_moves(:ZERO).should include ([:top_left, :top_center, :top_right])
    end

    it "should inform the available movements for x to win" do
        @board = Board.new("0-0x-x---")
        @board.winning_moves(:CROSS).should include ([:center_left, :center, :center_right])
        @board = Board.new("00x-x----")
        @board.winning_moves(:CROSS).should include ([:top_right, :center, :bottom_left])
    end

end