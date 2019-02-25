//
//  PlayerView.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 08..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import UIKit

protocol PlayerViewDelegate {
    func presentPlayersViewController()
}

struct PlayerViewContent {
    let playerImageName: String
    let name: String
    let percentage: String
    let total: String
    let wins: String
    let losses: String
}

class PlayerView: UIView {

    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentageView: UIView!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var staticTotalLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var staticWinsLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var staticLossesLabel: UILabel!
    @IBOutlet weak var lossesLabel: UILabel!
    
    var delegate: PlayerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        let view: UIView = Bundle.main.loadNibNamed("PlayerView", owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.percentageView.layer.cornerRadius = 12.5
        
        self.backgroundColor = .clear
        
        self.nameLabel.setupWithFont(.w3StatsBold, withSize: .small, withColor: .white)
        self.percentageLabel.setupWithFont(.w3Stats, withSize: .small, withColor: .black)
        self.staticTotalLabel.setupWithFont(.w3Stats, withSize: .tiny, withColor: .white)
        self.totalLabel.setupWithFont(.w3Stats, withSize: .large, withColor: .yellow)
        self.staticWinsLabel.setupWithFont(.w3Stats, withSize: .tiny, withColor: .white)
        self.winsLabel.setupWithFont(.w3Stats, withSize: .large, withColor: .yellow)
        self.staticLossesLabel.setupWithFont(.w3Stats, withSize: .tiny, withColor: .white)
        self.lossesLabel.setupWithFont(.w3Stats, withSize: .large, withColor: .yellow)
    }
    
    @IBAction func changePlayerTapped(_ sender: UIButton) {
        self.delegate?.presentPlayersViewController()
    }

    func displayContent(_ content: PlayerViewContent) {
        if let image = UIImage(named: content.playerImageName) {
            self.playerImageView.image = image
        }
        
        self.nameLabel.text = content.name
        self.percentageLabel.text = content.percentage
        self.totalLabel.text = content.total
        self.winsLabel.text = content.wins
        self.lossesLabel.text = content.losses
    }
}
