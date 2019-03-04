//
//  ViewController.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 07..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var versusScrollView: UIScrollView!
    @IBOutlet weak var vsHumanView: VersusView!
    @IBOutlet weak var vsElfView: VersusView!
    @IBOutlet weak var vsOrcView: VersusView!
    @IBOutlet weak var vsUndeadView: VersusView!
    @IBOutlet weak var addMatchResultView: AddMatchResultView!
    @IBOutlet weak var backgroundBlurView: UIView!
    @IBOutlet weak var checkmarkView: UIView!
    @IBOutlet weak var addMatchResultViewHeightConstraint: NSLayoutConstraint!
    
    var player: Player?
    
    private let provider: DataProviding = ObjectContainer.sharedInstance.dataProvider
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addMatchResultView.delegate = self
        self.playerView.delegate = self
        
        self.checkmarkView.layer.cornerRadius = 30
        
        self.setupVersusViewLongPressClosures()
        
        self.versusScrollView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 80, right: 0)
        
        self.presentPlayersVCWhenNoPlayerAvailable()
        
        self.showStats()
    }
    
    @IBAction func addMatchButtonTapped(_ sender: RoundedButton) {
        self.showAddMatchResultView()
    }
    
    @IBAction func tappedOnBackground(_ sender: UITapGestureRecognizer) {
        self.hideAddMatchResultView()
    }
    
    private func presentPlayersVCWhenNoPlayerAvailable() {
        guard player != nil else {
            self.presentPlayersViewController()
            return
        }
    }
    
    private func setupVersusViewLongPressClosures() {
        self.vsHumanView.onLongPress = { [weak self] result in
            self?.showEditAlertViewControllerForRace(.human, matchResult: result)
        }
        self.vsElfView.onLongPress = { [weak self] result in
            self?.showEditAlertViewControllerForRace(.elf, matchResult: result)
        }
        self.vsOrcView.onLongPress = { [weak self] result in
            self?.showEditAlertViewControllerForRace(.orc, matchResult: result)
        }
        self.vsUndeadView.onLongPress = { [weak self] result in
            self?.showEditAlertViewControllerForRace(.undead, matchResult: result)
        }
    }
    
    private func showEditAlertViewControllerForRace(_ race: Race, matchResult: MatchResult.ResultType) {
        let winString = self.getWinStringFrom(matchResult: matchResult)
        
        guard let currentValue = self.getCurrentValueFor(race: race, matchResult: matchResult) else {
            return
        }
        
        let editAlertController = UIAlertController(title: "\(race.displayableValue()) \(winString):", message: nil, preferredStyle: .alert)
        
        editAlertController.addTextField { (textField) in
            textField.delegate = self
            textField.keyboardType = .decimalPad
            textField.text = String(currentValue)
        }
        
        editAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        editAlertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
            guard let textField = editAlertController.textFields?.first, let text = textField.text, let newValue = Int(text) else {
                return
            }
            
            self.saveNewValue(newValue, forRace: race, matchResult: matchResult)
        }))
        
        self.present(editAlertController, animated: true, completion: nil)
    }
    
    private func getWinStringFrom(matchResult: MatchResult.ResultType) -> String {
        var winString: String
        
        switch matchResult {
        case .win:
            winString = "wins"
        case .lose:
            winString = "losses"
        }
        
        return winString
    }
    
    private func getCurrentValueFor(race: Race, matchResult: MatchResult.ResultType) -> Int? {
        guard let player = self.player else {
            return nil
        }
        
        var currentValue: Int
        
        switch matchResult {
        case .win:
            switch race {
            case .human:
                currentValue = player.stats.vsHuman.wins
            case .elf:
                currentValue = player.stats.vsElf.wins
            case .orc:
                currentValue = player.stats.vsOrc.wins
            case .undead:
                currentValue = player.stats.vsUndead.wins
            }
        case .lose:
            switch race {
            case .human:
                currentValue = player.stats.vsHuman.losses
            case .elf:
                currentValue = player.stats.vsElf.losses
            case .orc:
                currentValue = player.stats.vsOrc.losses
            case .undead:
                currentValue = player.stats.vsUndead.losses
            }
        }
        
        return currentValue
    }
    
    private func saveNewValue(_ newValue: Int, forRace race: Race, matchResult: MatchResult.ResultType) {
        guard let player = self.player else {
            return
        }
        
        switch matchResult {
        case .win:
            switch race {
            case .human:
                player.stats.vsHuman.wins = newValue
            case .elf:
                player.stats.vsElf.wins = newValue
            case .orc:
                player.stats.vsOrc.wins = newValue
            case .undead:
                player.stats.vsUndead.wins = newValue
            }
        case .lose:
            switch race {
            case .human:
                player.stats.vsHuman.losses = newValue
            case .elf:
                player.stats.vsElf.losses = newValue
            case .orc:
                player.stats.vsOrc.losses = newValue
            case .undead:
                player.stats.vsUndead.losses = newValue
            }
        }
        
        self.provider.updatePlayer(player: player) {
            self.presentAlertWithMessage("Could not save new match result.")
        }
        
        self.showStats()
    }
    
    private func showStats() {
        guard let player = self.player else {
            return
        }
        
        let vsHumanStat = StatsUtil.calculateStat(wins: player.stats.vsHuman.wins, losses: player.stats.vsHuman.losses)
        let vsHumanViewContent = self.getVersusViewContent(from: vsHumanStat, for: .human)
        self.vsHumanView.displayContent(vsHumanViewContent)
        
        let vsElfStat = StatsUtil.calculateStat(wins: player.stats.vsElf.wins, losses: player.stats.vsElf.losses)
        let vsElfViewContent = self.getVersusViewContent(from: vsElfStat, for: .elf)
        self.vsElfView.displayContent(vsElfViewContent)
        
        let vsOrcStat = StatsUtil.calculateStat(wins: player.stats.vsOrc.wins, losses: player.stats.vsOrc.losses)
        let vsOrcViewContent = self.getVersusViewContent(from: vsOrcStat, for: .orc)
        self.vsOrcView.displayContent(vsOrcViewContent)
        
        let vsUndeadStat = StatsUtil.calculateStat(wins: player.stats.vsUndead.wins, losses: player.stats.vsUndead.losses)
        let vsUndeadViewContent = self.getVersusViewContent(from: vsUndeadStat, for: .undead)
        self.vsUndeadView.displayContent(vsUndeadViewContent)
        
        let wins = vsHumanStat.wins + vsElfStat.wins + vsOrcStat.wins + vsUndeadStat.wins
        let losses = vsHumanStat.losses + vsElfStat.losses + vsOrcStat.losses + vsUndeadStat.losses
        
        let playerStat = StatsUtil.calculateStat(wins: wins, losses: losses)
        let playerViewContent = PlayerViewContent.init(playerImageName: player.race.rawValue,
                                                       name: player.name,
                                                       percentage: "\(playerStat.percentage)%",
                                                        total: "\(playerStat.total)",
                                                        wins: "\(playerStat.wins)",
                                                        losses: "\(playerStat.losses)")
        self.playerView.displayContent(playerViewContent)
    }
    
    private func getVersusViewContent(from stat: Stat, for race: Race) -> VersusViewContent {
        let versusHeaderViewContent = VersusHeaderViewContent.init(raceImageName: race.rawValue, percentage: "\(stat.percentage)%")
        return VersusViewContent.init(versusHeaderViewContent: versusHeaderViewContent,
                                        total: "\(stat.total)",
                                        wins: "\(stat.wins)",
                                        losses: "\(stat.losses)")
    }
    
    private func showAddMatchResultView() {
        self.blurBackground()
        self.animateAddMatchResultViewHeight(to: 500)
    }
    
    private func hideAddMatchResultView() {
        self.animateAddMatchResultViewHeight(to: 0)
        self.unblurBackground()
    }
    
    private func animateAddMatchResultViewHeight(to constant: CGFloat) {
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.1,
                       options: [.curveLinear],
                       animations: {
                        self.addMatchResultViewHeightConstraint.constant = constant
                        self.view.layoutIfNeeded()
        },
                       completion: nil
        )
    }
    
    private func blurBackground() {
        self.backgroundBlurView.alpha = 0
        self.backgroundBlurView.isHidden = false
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.backgroundBlurView.alpha = 0.7
                        self.view.layoutIfNeeded()
        })
    }
    
    private func unblurBackground() {
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.backgroundBlurView.alpha = 0
                        self.view.layoutIfNeeded()
        },
                       completion: { _ in
                        self.backgroundBlurView.isHidden = true
        })
    }
    
    private func presentAlertWithMessage(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func showCheckmark() {
        self.checkmarkView.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.5,
                           animations: {
                            self.checkmarkView.alpha = 0
                            self.view.layoutIfNeeded()
            }, completion: { _ in
                self.checkmarkView.isHidden = true
                self.checkmarkView.alpha = 0.9
            })
        })
    }
}

extension StatsViewController: MatchResultDelegate {
    func addNewMatchResult(_ matchResult: MatchResult) {
        guard let player = self.player else {
            return
        }
        
        switch matchResult.resultType {
        case .win:
            switch matchResult.vsRace {
            case .human:
                player.stats.vsHuman.wins += 1
            case .elf:
                player.stats.vsElf.wins += 1
            case .orc:
                player.stats.vsOrc.wins += 1
            case .undead:
                player.stats.vsUndead.wins += 1
            }
        case .lose:
            switch matchResult.vsRace {
            case .human:
                player.stats.vsHuman.losses += 1
            case .elf:
                player.stats.vsElf.losses += 1
            case .orc:
                player.stats.vsOrc.losses += 1
            case .undead:
                player.stats.vsUndead.losses += 1
            }
        }
        
        self.provider.updatePlayer(player: player) {
            self.presentAlertWithMessage("Could not save new match result.")
        }
        
        self.showStats()
        self.hideAddMatchResultView()
        self.showCheckmark()
    }
}

extension StatsViewController: PlayerViewDelegate {
    func presentPlayersViewController() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let playersViewController = storyboard.instantiateViewController(withIdentifier: "PlayersViewController") as? PlayersViewController else {
                return
            }
            
            playersViewController.delegate = self
            
            self.present(playersViewController, animated: true, completion: nil)
        }
    }
}

extension StatsViewController: PlayersViewControllerDelegate {
    func updateStatsForPlayer(_ playerName: String) {
        self.player = self.provider.loadPlayer(name: playerName)
        self.showStats()
    }
}

extension StatsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn: "0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
}
