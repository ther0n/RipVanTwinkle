extends Control

onready var board = [ [$TicTacButton1, $TicTacButton2, $TicTacButton3],
					  [$TicTacButton4, $TicTacButton5, $TicTacButton6],
					  [$TicTacButton7, $TicTacButton8, $TicTacButton9], 
					]

# We use these player values for two purposes
# To distiguish the "activePlayer", and to make
# scoring easy.
const X = 1
const O = 10

var activePlayer = X
var currentRound = 0
var lost = false

func _ready():
	PlayerState.state["wonTicTacToe"] = false
	# Setup our playing board
	for row in board:
		for btn in row:
			btn.connect( "custom_pressed", self, "onTicTacBtnPressed" )

func clearBoard():
	# Resets the game for a new round
	currentRound = 0
	lost = false
	activePlayer = X
	# Resets the board
	for row in board:
		for btn in row:
			btn.reset()

func placeMark( row, col, player ):
	# This function places a mark on the board - by placing
	# a mark we are setting the value of that button to
	# the player values assigned at the beginning of this
	# script.
	
	# Note after setting the board value, we swap the 
	# active player.
	if player == X:
		board[row][col].setX(X)
		activePlayer = O
	else:
		board[row][col].setO(O)
		activePlayer = X
	
	# After setting the values we increase the round number
	# to the next turn.
	currentRound += 1
	
	# Now we check for win conditions.
	checkWin()

		
	if activePlayer == O and not lost:
		# We use the tween to "fake" the computer thinking. I probably
		# could have used a timer instead, but the interpolate_callback
		# method makes it simple to provide a callback to the AI.
		$Tween.interpolate_callback( self, 0.5 + randf(), "aiPicPoint" )
		$Tween.start()

func sumRow( rowNum ):
	# Returns the sum of the supplied row
	# Passing an invalid row returns 0
	var sum = 0
	for btn in board[rowNum]:
		sum += btn.value
	return sum

func sumCol( colNum):
	# Returns the sum of the supplied column
	# Passing an invalid column returns 0
	var sum = 0
	for row in board:
		sum += row[ colNum ].value
	return sum

func sumDiag_1():
	# Returns the sum of the diagonal from (0,0) to (2,2)
	var sum = 0
	for idx in range(3):
		sum += board[idx][idx].value
		
	return sum

func sumDiag_2():
	# Returns the sum of the diagonal from (0,2) to (2,0)
	var sum = 0 
	for idx in range(3):
		sum += board[idx][2-idx].value
	return sum

func checkWin():
	# Checks the possible win states of the game
	# NOTE: Since we setup the player values as
	#       1 for Rip Van Twinkle and 10 for Alien
	#       we can check the sum along the rows
	#       and diagonals. A sum of 3 means Rip Van Twinkle
	#       owns it while a sum of 30 means Alien
	#       owns it.
	var row = 0
	var col = 0
	var d1 = 0
	var d2 = 0
	
	for idx in range(3):
		row = sumRow(idx)
		print( "Row %d Sum: %d" % [idx,row] )
		if row == 3:
			PlayerState.state["wonTicTacToe"] = true
			clearBoard()
		elif row == 30:
			lost = true
			clearBoard()
			
		col = sumCol(idx)
		print( "Col %d Sum: %d" % [idx, col] )
		if col == 3:
			PlayerState.state["wonTicTacToe"] = true
			clearBoard()
		elif col == 30:
			lost = true
			clearBoard()
		
	d1 = sumDiag_1()
	d2 = sumDiag_2()
	print( "Diag 1 : %d" % d1)
	if d1 == 3 or d2 == 3:
		PlayerState.state["wonTicTacToe"] = true
		clearBoard()
	elif d1 == 30 or d2 == 30:
		lost = true
		clearBoard()
	print( "Diag 2 : %d" % sumDiag_2() )
	if lost:
		Utils.showDialog("You lost!", "The alien wants to play again!")
		clearBoard()
	elif currentRound == 9 and !PlayerState.state["wonTicTacToe"]:
		Utils.showDialog("Draw!", "The alien wants to play again.")
		clearBoard()
	elif PlayerState.state["wonTicTacToe"]:
		Utils.showDialog("You won!", "You defeated the alien in TicTacToe!")
		yield(get_node("/root/Utils/Dialog/CanvasLayer/PopupDialog/MarginContainer/VBoxContainer/Button"), "pressed")
		PlayerState.next_scene()
		
	
func onTicTacBtnPressed( button ):
	
	# When a TicTacButton is pressed, it fires a signal
	# We've registered to "respond" to that signal here.
	if activePlayer == X:
		print("Pressed (%d, %d)" % [button.row, button.col] )
		
		if board[button.row][button.col].value != 0:
			print("Already filled")
		else:
			placeMark( button.row, button.col, activePlayer )
		

func aiFillRow( row ):
	# AI tries to fill the supplied row with the first available
	# open button.
	for column in range(3):
		if board[ row ][ column ].value == 0:
			placeMark( row, column, activePlayer )

func aiFillCol( col ):
	# AI tries to fill the supplied column with the first available
	# open button.
	for row in range(3):
		if board[ row ][ col ].value == 0:
			placeMark( row, col, activePlayer )

func aiFillDiag_1():
	# AI tries to fill the supplied diagonal with the first available
	# open button.
	for idx in range(3):
		if board[idx][idx].value == 0:
			placeMark( idx, idx, activePlayer )

func aiFillDiag_2():
	# AI tries to fill the supplied diagonal with the first available
	# open button.
	for idx in range(3):
		if board[idx][2-idx].value == 0:
			placeMark( idx, 2-idx, activePlayer )

func aiPicWinningFill():
	# Try to win first by checking for any row, col or diag
	# that equals 20, meaning we can fill it and win the game
	for idx in range(3):
		if sumRow( idx ) == 20:
			# We can win by filling in the row
			aiFillRow( idx )
			return true
		elif sumCol( idx ) == 20:
			# we can win by filling in the column
			aiFillCol( idx )
			return true
	if sumDiag_1() == 20:
		# we can win by filling in the diagonal
		aiFillDiag_1()
		return true
	elif sumDiag_2() == 20:
		# we can win by filling in the diagonal
		aiFillDiag_2()
		return true
		
	return false

func aiBlock():
	# Because of the way we setup the scoring, with the Rip Van Twinkle having
	# a value of one (1) .. We know that if a row has the sum of 2, then 
	# the player has 2 positions filled and 1 position open for the win.
	# In this case, the computer wants to block that position.
	for idx in range(3):
		if sumRow( idx ) == 2:
			# Need to block
			aiFillRow( idx )
			return true
		elif sumCol( idx ) == 2:
			aiFillCol( idx )
			return true
	if sumDiag_1() == 2:
		aiFillDiag_1()
		return true
	elif sumDiag_2() == 2:
		aiFillDiag_2()
		return true
	
	return false

func aiPicPoint():
	# Checks for obvious win
	# Checks for obvious block
	# Then just chooses random
	if not aiPicWinningFill():
		if not aiBlock():
			var row = randi() % 3
			var col = randi() % 3
			var valid = false
			
			# FIXME: This is a terrible way to do this
			while not valid:
				if board[row][col].value == 0:
					valid = true
				else:
					row = randi() % 3
					col = randi() % 3
				
			placeMark( row, col, activePlayer )
