//
//  VersusHeaderView.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 25..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import UIKit

struct VersusHeaderViewContent {
    let raceImageName: String
    let percentage: String
}

class VersusHeaderView: UIView {

    @IBOutlet weak var raceImageView: UIImageView!
    @IBOutlet weak var vsLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var percentageView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        let view: UIView = Bundle.main.loadNibNamed("VersusHeaderView", owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.percentageView.layer.cornerRadius = 12.5
        
        self.backgroundColor = .clear
        
        self.vsLabel.setupWithFont(.w3Stats, withSize: .tiny, withColor: .black)
        self.percentageLabel.setupWithFont(.w3Stats, withSize: .small, withColor: .black)
    }
    
    func displayContent(_ content: VersusHeaderViewContent) {
        if let image = UIImage(named: content.raceImageName) {
            self.raceImageView.image = image
        }
        
        self.percentageLabel.text = content.percentage
    }

}
