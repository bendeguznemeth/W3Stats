//
//  PlayerView.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 08..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import UIKit

struct PlayerViewContent {
    let playerImageName: String
    let name: String
    let percentage: String
    let total: String
    let wins: String
    let losses: String
}

class PlayerView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var lossesLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("PlayerView", owner: self, options: nil)
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.innerView.layer.cornerRadius = 15
    }
    
    @IBAction func changePlayerTapped(_ sender: UIButton) {
        // TODO
        print("tapped")
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
