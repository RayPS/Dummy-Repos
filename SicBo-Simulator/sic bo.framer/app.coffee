roll = ->
	dice = -> Utils.randomChoice [1..6]
	dices = do -> [dice(), dice(), dice()]
	add = (a, b) -> return a + b
	sum = dices.reduce(add, 0)
	result =
		dices: dices
		isBig: sum > 10
		isTripple: dices[0] == dices[1] == dices[2]
	return result

deal = (bet, isBig) ->
	result = roll()
	if result.isTripple
		return 0
	else if isBig == result.isBig
		return 2
	else
		return 0

wallet = 100000

for i in [0..100000]
	wallet -= 1
	wallet += deal(1, true)
	print wallet