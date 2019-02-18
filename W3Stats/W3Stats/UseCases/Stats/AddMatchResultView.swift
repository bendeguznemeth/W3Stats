//
//  AddMatchResultView.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 12..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import UIKit

protocol MatchResultDelegate {
    func addNewMatchResult(_ matchResult: MatchResult)
}

struct MatchResult {
    var vsRace: Race
    var win: Bool
}

class AddMatchResultView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var racePickerView: UIPickerView!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var loseLabel: UILabel!
    
    private var matchResult = MatchResult(vsRace: .human, win: true)
    
    var delegate: MatchResultDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("AddMatchResultView", owner: self, options: nil)
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.racePickerView.dataSource = self
        self.racePickerView.delegate = self
        
        self.racePickerView.selectRow(1, inComponent: 0, animated: false)
    }
    
    @IBAction func tapOnWin(_ sender: UITapGestureRecognizer) {
        self.loseLabel.alpha = 0.2
        self.winLabel.alpha = 1
        
        self.matchResult.win = true
    }
    
    @IBAction func tapOnLose(_ sender: UITapGestureRecognizer) {
        self.winLabel.alpha = 0.2
        self.loseLabel.alpha = 1
        
        self.matchResult.win = false
    }
    
    @IBAction func tapOnSave(_ sender: UIButton) {
        self.delegate?.addNewMatchResult(self.matchResult)
    }
}

extension AddMatchResultView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Race.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Race.allRaces[row].displayableValue()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.matchResult.vsRace = Race.allRaces[row]
    }
}
