//
//  PlayersViewController.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 08..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import UIKit

protocol PlayersViewControllerDelegate {
    func updateUI()
}

class PlayersViewController: UIViewController {
    
    @IBOutlet weak var playersTableView: UITableView!
    
    var players = [Player(name: "Balázs Papp", species: .human),
                   Player(name: "Kristóf Varga", species: .orc),
                   Player(name: "Balázs Németh", species: .elf),
                   Player(name: "János Csizmadia", species: .human),
                   Player(name: "Gábor Demkó", species: .undead)]
    
    var delegate: PlayersViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playersTableView.dataSource = self
        self.playersTableView.delegate = self
        
        let cellNib = UINib(nibName: "PlayerCell", bundle: nil)
        self.playersTableView.register(cellNib, forCellReuseIdentifier: "PlayerCell")
    }
    
    @IBAction func addPlayerButtonTapped(_ sender: AddButton) {
        // TODO
    }
}

extension PlayersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell") as? PlayerCell else {
            return UITableViewCell()
        }
        
        let name = self.players[indexPath.row].name
        let imageName = self.players[indexPath.row].species.rawValue
        
        let cellContent = PlayerCellContent.init(playerImageName: imageName, name: name)
        
        cell.displayContent(cellContent)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            guard let statsViewController = self.presentingViewController as? StatsViewController else {
                return
            }
            
            statsViewController.player.name = self.players[indexPath.row].name
            statsViewController.player.species = self.players[indexPath.row].species
            
            self.delegate?.updateUI()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}
