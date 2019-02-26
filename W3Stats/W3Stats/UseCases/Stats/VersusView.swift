//
//  VersusView.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 08..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import UIKit

struct VersusViewContent {
    let versusHeaderViewContent: VersusHeaderViewContent
    let total: String
    let wins: String
    let losses: String
}

class VersusView: UIView {

    @IBOutlet weak var versusHeaderView: VersusHeaderView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var staticTotalLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var staticWinsLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var staticLossesLabel: UILabel!
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
        
        self.staticTotalLabel.setupWithFont(.w3Stats, withSize: .tiny, withColor: .white)
        self.totalLabel.setupWithFont(.w3Stats, withSize: .large, withColor: .yellow)
        self.staticWinsLabel.setupWithFont(.w3Stats, withSize: .tiny, withColor: .white)
        self.winsLabel.setupWithFont(.w3Stats, withSize: .large, withColor: .yellow)
        self.staticLossesLabel.setupWithFont(.w3Stats, withSize: .tiny, withColor: .white)
        self.lossesLabel.setupWithFont(.w3Stats, withSize: .large, withColor: .yellow)
    }

    func displayContent(_ content: VersusViewContent) {
        self.versusHeaderView.displayContent(content.versusHeaderViewContent)
        
        self.totalLabel.text = content.total
        self.winsLabel.text = content.wins
        self.lossesLabel.text = content.losses
    }
}
