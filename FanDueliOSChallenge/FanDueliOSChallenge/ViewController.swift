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
    
    var rightGuesses: Int = 0
    var wrongGuesses: Int = 0
    
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
        
        navigationItem.title = "Right: \(rightGuesses) -- Wrong: \(wrongGuesses)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetButtonTapped(sender: AnyObject) {
        players = players.shuffle()
        cellViewModels.removeAll()
        rightGuesses = 0
        wrongGuesses = 0
        navigationItem.title = "Right: \(rightGuesses) -- Wrong: \(wrongGuesses)"
        for i in 0..<(players.count/2) {
            cellViewModels.append(PickMatchCellViewModel(rightPlayer: players[2*i], leftPlayer: players[2*i+1]))
        }
        tableView.reloadData()
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
    func rightTapped(viewModel: PickMatchCellViewModel?) {
        guard let viewModel = viewModel else {
            assertionFailure("Tap occured without a view model!")
            return
        }
        
        if viewModel.didGuessCorrectly {
            rightGuesses += 1
        } else {
            wrongGuesses += 1
        }
        navigationItem.title = "Right: \(rightGuesses) -- Wrong: \(wrongGuesses)"
        
        checkWin()
    }
    
    func leftTapped(viewModel: PickMatchCellViewModel?) {
        guard let viewModel = viewModel else {
            assertionFailure("Tap occured without a view model!")
            return
        }
        
        if viewModel.didGuessCorrectly {
            rightGuesses += 1
        } else {
            wrongGuesses += 1
        }
        navigationItem.title = "Right: \(rightGuesses) -- Wrong: \(wrongGuesses)"
        
        checkWin()
    }
    
    func checkWin() {
        if rightGuesses >= 10 {
            let alertController = UIAlertController(title: "You won!", message: "Time to play again?", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: {
                action in
                
                self.resetButtonTapped(self)
            }))
            
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
}

extension CollectionType {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}