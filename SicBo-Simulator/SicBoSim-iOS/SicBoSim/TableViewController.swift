//
//  TableViewController.swift
//  SicBoSim
//
//  Created by Ray on 25/02/2018.
//  Copyright © 2018 Ray. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var data: [DiceRollResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false

        generate(100)
    }

    func generate(_ numberOfItems: Int) {
        data = []

        for _ in 1...numberOfItems {
            data.append(roll())
        }

        tableView.reloadData()
    }

    @IBAction func regenerate(_ sender: Any) {
        generate(100)
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! ReusableCell

        let coloredLabels = [cell.diceLabel, cell.totalLabel]
        let stateLabels = [cell.bigLabel, cell.smallLabel, cell.trippleLabel]
        for label in stateLabels {
            label!.textColor = .clear
        }

        let result = data[indexPath.row]

        cell.diceLabel.text = result.dices.map({String($0)}).joined(separator: " ")
        cell.totalLabel.text = String(result.sum)

        switch result.state {
        case .Big:
            for label in coloredLabels + [cell.bigLabel] {
                label?.textColor = .red
            }
        case .Small:
            for label in coloredLabels + [cell.smallLabel] {
                label?.textColor = .yellow
            }
        case .Tripple:
            for label in coloredLabels + [cell.trippleLabel] {
                label?.textColor = .green
            }
        }
        return cell
    }

}

class ReusableCell: UITableViewCell  {
    @IBOutlet weak var diceLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var bigLabel: UILabel!
    @IBOutlet weak var smallLabel: UILabel!
    @IBOutlet weak var trippleLabel: UILabel!
}
