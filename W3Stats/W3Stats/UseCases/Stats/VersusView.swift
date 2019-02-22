//
//  VersusView.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 08..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import UIKit

struct VersusViewContent {
    let raceImageName: String
    let percentage: String
    let total: String
    let wins: String
    let losses: String
}

class VersusView: UIView {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var raceImageView: UIImageView!
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
        let view: UIView = Bundle.main.loadNibNamed("VersusView", owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.backgroundColor = .clear
        
        self.innerView.layer.cornerRadius = 15
    }

    func displayContent(_ content: VersusViewContent) {
        if let image = UIImage(named: content.raceImageName) {
            self.raceImageView.image = image
        }
        
        self.percentageLabel.text = content.percentage
        self.totalLabel.text = content.total
        self.winsLabel.text = content.wins
        self.lossesLabel.text = content.losses
    }
}
