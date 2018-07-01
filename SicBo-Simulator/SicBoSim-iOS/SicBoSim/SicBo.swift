//
//  SicBo.swift
//  SicBoSim
//
//  Created by Ray on 25/02/2018.
//  Copyright © 2018 Ray. All rights reserved.
//

import Foundation

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
        dices: dices.sorted{$0 < $1},
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

