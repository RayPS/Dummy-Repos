import UIKit

enum DiceRollState {
    case Big
    case Small
    case Tripple
}

struct DiceRollResult {
    var dices: [Int]
    var sum: Int
    var state: DiceRollState
}

func dice() -> Int {
    return Int(arc4random_uniform(6) + 1)
}


func roll() -> DiceRollResult {
    let dices = [dice(), dice(), dice()]
    let sum = dices.reduce(0, { a, b in a + b })

    return DiceRollResult(
        dices: dices,
        sum: sum,
        state: {
            if dices.min() == dices.max() {
                return .Tripple
            } else if sum > 10 {
                return .Big
            } else {
                return .Small
            }
        }()
    )
}



for i in 1...100 {
    let result = roll()
}
