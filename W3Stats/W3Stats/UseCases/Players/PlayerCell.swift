//
//  PlayerCell.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 08..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import UIKit

struct PlayerCellContent {
    let playerImageName: String
    let name: String
}

class PlayerCell: UITableViewCell {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.innerView.layer.cornerRadius = 10
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.nameLabel.setupWithFont(.w3Stats, withSize: .normal, withColor: .white)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func displayContent(_ content: PlayerCellContent) {
        if let image = UIImage(named: content.playerImageName) {
            self.playerImageView.image = image
        }
        
        self.nameLabel.text = content.name
    }
}
