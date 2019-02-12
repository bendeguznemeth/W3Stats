//
//  ViewController.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 07..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    struct Stat {
        let wins: Int
        let losses: Int
        let total: Int
        let percentage: Int
    }
    
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var vsHumanView: VersusView!
    @IBOutlet weak var vsElfView: VersusView!
    @IBOutlet weak var vsOrcView: VersusView!
    @IBOutlet weak var vsUndeadView: VersusView!
    
    let player = Player(name: "Balázs Papp", species: .human, stats: Stats(vsHuman: Desc(wins: 23, losses: 11),
                                                                            vsElf: Desc(wins: 22, losses: 8),
                                                                            vsOrc: Desc(wins: 33, losses: 14),
                                                                            vsUndead: Desc(wins: 21, losses: 9)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showStats()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    private func showStats() {
        let vsHumanStat = self.calculateStat(wins: self.player.stats.vsHuman.wins, losses: self.player.stats.vsHuman.losses)
        let vsHumanViewContent = self.getVersusViewContent(from: vsHumanStat, for: .human)
        self.vsHumanView.displayContent(vsHumanViewContent)
        
        let vsElfStat = self.calculateStat(wins: self.player.stats.vsElf.wins, losses: self.player.stats.vsElf.losses)
        let vsElfViewContent = self.getVersusViewContent(from: vsElfStat, for: .elf)
        self.vsElfView.displayContent(vsElfViewContent)
        
        let vsOrcStat = self.calculateStat(wins: self.player.stats.vsOrc.wins, losses: self.player.stats.vsOrc.losses)
        let vsOrcViewContent = self.getVersusViewContent(from: vsOrcStat, for: .orc)
        self.vsOrcView.displayContent(vsOrcViewContent)
        
        let vsUndeadStat = self.calculateStat(wins: self.player.stats.vsUndead.wins, losses: self.player.stats.vsUndead.losses)
        let vsUndeadViewContent = self.getVersusViewContent(from: vsUndeadStat, for: .undead)
        self.vsUndeadView.displayContent(vsUndeadViewContent)
        
        let wins = vsHumanStat.wins + vsElfStat.wins + vsOrcStat.wins + vsUndeadStat.wins
        let losses = vsHumanStat.losses + vsElfStat.losses + vsOrcStat.losses + vsUndeadStat.losses
        
        let playerStat = self.calculateStat(wins: wins, losses: losses)
        let playerViewContent = PlayerViewContent.init(playerImageName: self.player.species.rawValue,
                                                        name: self.player.name,
                                                        percentage: "\(playerStat.percentage) %",
                                                        total: "\(playerStat.total)",
                                                        wins: "\(playerStat.wins)",
                                                        losses: "\(playerStat.losses)")
        self.playerView.displayContent(playerViewContent)
    }
    
    private func calculateStat(wins: Int, losses: Int) -> Stat {
        let total = wins + losses
        let percentage = Double(wins) / Double(total) * 100
        return Stat(wins: wins, losses: losses, total: total, percentage: Int(percentage))
    }
    
    private func getVersusViewContent(from stat: Stat, for species: Species) -> VersusViewContent {
        return VersusViewContent.init(speciesImageName: species.rawValue,
                                        percentage: "\(stat.percentage) %",
                                        total: "\(stat.total)",
                                        wins: "\(stat.wins)",
                                        losses: "\(stat.losses)")
    }
}

