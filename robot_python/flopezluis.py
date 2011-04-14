players = ('0','X')
turn = 0
exit = False
board = {0:'-', 1:'-',2:'-', 3:'-', 4:'-',5:'-',6:'-', 7:'-',8:'-'}
win_combinatios= [[0,1,2], \
                  [3,4,5], \
                  [6,7,8], \
                  [0,3,6], \
                  [1,4,7], \
                  [2,5,8], \
                  [0,4,8], \
                  [2,4,6]]

def get_string_board():
    str_board = [''.join(row) for row in board.values()]
    return  ''.join(board.values())

def check_win(key):
    for com in win_combinatios:
        if key in com:
            com[com.index(key)] = board[key]
            if com.count(board[key]) == 3: return True            
    return False
        
if __name__ == "__main__":
    while (not exit):
        new_turn = input(get_string_board() + "\n:")
        if board[new_turn] != "-": 
            print "Repeat please\n"
        else:
            board[new_turn]=players[turn]
            turn = not turn
            if check_win(new_turn):
                print "WIN ->%c" %board[new_turn]
                exit = True