//
//  RacePickerViewCell.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 21..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import UIKit

struct RacePickerViewCellContent {
    let raceImageName: String
    let raceName: String
}

class RacePickerViewCell: UIView {
    
    @IBOutlet weak var raceImageView: UIImageView!
    @IBOutlet weak var raceLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        let view: UIView = Bundle.main.loadNibNamed("RacePickerViewCell", owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func displayContent(_ content: RacePickerViewCellContent) {
        if let image = UIImage(named: content.raceImageName) {
            self.raceImageView.image = image
        }
        
        self.raceLabel.text = content.raceName
    }
}
