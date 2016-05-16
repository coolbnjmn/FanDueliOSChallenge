//
//  ViewController.swift
//  FanDueliOSChallenge
//
//  Created by Benjamin Hendricks on 5/12/16.
//  Copyright © 2016 coolbnjmn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var players: [Player] = [] {
        didSet {
            for i in 0..<(players.count/2) {
                cellViewModels.append(PickMatchCellViewModel(rightPlayer: players[2*i], leftPlayer: players[2*i+1]))
            }
        }
    }
    var teams: [Team] = []
    var cellViewModels: [PickMatchCellViewModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        APIManager.sharedInstance.fetchJSON {
            success, players, teams in
            if success {
                self.players = players
                self.teams = teams
            }
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("PickMatchTableViewCell", forIndexPath: indexPath) as? PickMatchTableViewCell {
            cell.viewModel = cellViewModels[indexPath.row]
            cell.delegate = self
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ViewController: PickMatchTableViewCellDelegate {
    func rightTapped(playerId: String?) {
        guard let playerId = playerId else {
            assertionFailure("Tap occured without an id!")
            return
        }
        print(playerId)
    }
    
    func leftTapped(playerId: String?) {
        guard let playerId = playerId else {
            assertionFailure("Tap occured without an id!")
            return
        }
        print(playerId)
    }
}