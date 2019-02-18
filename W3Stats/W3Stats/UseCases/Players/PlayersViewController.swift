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
    @IBOutlet weak var addPlayerView: AddPlayerView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var addPlayerViewBottomConstraint: NSLayoutConstraint!
    
    var players = [Player(name: "Balázs Papp", race: .human),
                   Player(name: "Kristóf Varga", race: .orc),
                   Player(name: "Balázs Németh", race: .elf),
                   Player(name: "János Csizmadia", race: .human),
                   Player(name: "Gábor Demkó", race: .undead)]
    
    var delegate: PlayersViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playersTableView.dataSource = self
        self.playersTableView.delegate = self
        
        self.addPlayerView.delegate = self
        
        let cellNib = UINib(nibName: "PlayerCell", bundle: nil)
        self.playersTableView.register(cellNib, forCellReuseIdentifier: "PlayerCell")
        
        self.bindToKeyboard()
    }
    
    deinit {
        self.unbindToKeyboard()
    }
    
    @IBAction func tappedOnVisualEffectView(_ sender: UITapGestureRecognizer) {
        self.addPlayerView.nameTextField.resignFirstResponder()
        self.hideAddPlayerView()
        self.hideVisualEffectViewWithAnimation()
    }
    
    @IBAction func addPlayerButtonTapped(_ sender: AddButton) {
        self.showVisualEffectViewWithAnimation()
        self.showAddPlayerView()
    }
    
    private func showVisualEffectViewWithAnimation() {
        self.visualEffectView.alpha = 0
        self.visualEffectView.isHidden = false
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.visualEffectView.alpha = 1
                        self.view.layoutIfNeeded()
        })
    }
    
    private func hideVisualEffectViewWithAnimation() {
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
    
    private func showAddPlayerView() {
        animate(with: -40)
    }
    
    private func hideAddPlayerView() {
        animate(with: -260)
    }
    
    private func animate(with constant: CGFloat) {
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.1,
                       options: [.curveLinear],
                       animations: {
                        self.addPlayerViewBottomConstraint.constant = constant
                        self.view.layoutIfNeeded()
        },
                       completion: nil
        )
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
            guard let statsViewController = self.presentingViewController as? StatsViewController else {
                return
            }
            
            statsViewController.player.name = self.players[indexPath.row].name
            statsViewController.player.race = self.players[indexPath.row].race
            
            self.delegate?.updateUI()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension PlayersViewController: AddPlayerDelegate {
    func addNewPlayer(_ playerResult: PlayerResult) {
        guard let name = playerResult.name else {
            return
        }
        
        self.players.append(Player(name: name, race: playerResult.race))
        self.playersTableView.reloadData()
        
        self.hideAddPlayerView()
        self.hideVisualEffectViewWithAnimation()
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
                self.addPlayerViewBottomConstraint?.constant = 0.0
            } else {
                self.addPlayerViewBottomConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
}
