//
//  PlayersViewController.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 08..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import UIKit

protocol PlayersViewControllerDelegate {
    func updateStatsForPlayer(_ playerName: String)
}

class PlayersViewController: UIViewController {
    
    @IBOutlet weak var playersTableView: UITableView!
    @IBOutlet weak var addPlayerView: AddPlayerView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var addPlayerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var addPlayerViewBottomConstraint: NSLayoutConstraint!
    
    var players = [Player]()
    
    var delegate: PlayersViewControllerDelegate?
    
    private let provider: DataProviding = ObjectContainer.sharedInstance.dataProvider
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playersTableView.dataSource = self
        self.playersTableView.delegate = self
        
        self.addPlayerView.delegate = self
        
        let cellNib = UINib(nibName: "PlayerCell", bundle: nil)
        self.playersTableView.register(cellNib, forCellReuseIdentifier: "PlayerCell")
        
        self.bindToKeyboard()
        
        players = self.provider.loadPlayers()
        
        if players.count == 0 {
            self.showAddPlayerView()
        }
    }
    
    deinit {
        self.unbindToKeyboard()
    }
    
    @IBAction func tappedOnBackground(_ sender: UITapGestureRecognizer) {
        if players.count != 0 {
            self.addPlayerView.nameTextField.resignFirstResponder()
            self.hideAddPlayerView()
        }
    }
    
    @IBAction func addPlayerButtonTapped(_ sender: RoundedButton) {
        self.showAddPlayerView()
    }
    
    private func showAddPlayerView() {
        self.blurBackground()
        self.animateAddPayerViewHeight(to: 436)
    }
    
    private func hideAddPlayerView() {
        self.animateAddPayerViewHeight(to: 0)
        self.unblurBackground()
    }
    
    private func animateAddPayerViewHeight(to constant: CGFloat) {
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.1,
                       options: [.curveLinear],
                       animations: {
                        self.addPlayerViewHeightConstraint.constant = constant
                        self.view.layoutIfNeeded()
        },
                       completion: nil
        )
    }
    
    private func blurBackground() {
        self.visualEffectView.alpha = 0
        self.visualEffectView.isHidden = false
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.visualEffectView.alpha = 1
                        self.view.layoutIfNeeded()
        })
    }
    
    private func unblurBackground() {
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.visualEffectView.alpha = 0
                        self.view.layoutIfNeeded()
        },
                       completion: { _ in
                        self.visualEffectView.isHidden = true
        })
    }
    
    private func presentAlertWithMessage(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
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
        let imageName = self.players[indexPath.row].race.rawValue
        
        let cellContent = PlayerCellContent.init(playerImageName: imageName, name: name)
        
        cell.displayContent(cellContent)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let playerName = self.players[indexPath.row].name
            
            self.delegate?.updateStatsForPlayer(playerName)
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let name = players[indexPath.row].name
            
            self.provider.deletePlayer(name: name) {
                self.presentAlertWithMessage("Failed to delete player.")
                return
            }
            
            self.players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension PlayersViewController: AddPlayerDelegate {
    func addNewPlayer(_ playerResult: AddPlayerView.NewPlayer) {
        let player = Player(name: playerResult.name, race: playerResult.race, stats: Stats(vsHuman: Desc(), vsElf: Desc(), vsOrc: Desc(), vsUndead: Desc()))
        
        self.provider.savePlayer(player: player) {
            self.presentAlertWithMessage("Failed to save player.")
            return
        }
        
        self.players.append(player)
        self.playersTableView.reloadData()
        
        self.hideAddPlayerView()
    }
}

extension PlayersViewController {
    func bindToKeyboard(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    func unbindToKeyboard(){
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.addPlayerViewBottomConstraint.constant = 0.0
            } else {
                self.addPlayerViewBottomConstraint.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
}
