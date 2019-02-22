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

class AddMatchResultView: UIView {
    
    @IBOutlet weak var racePicker: UIPickerView!
    @IBOutlet weak var winButton: RoundedButton!
    @IBOutlet weak var loseButton: RoundedButton!
    
    private var matchResult = MatchResult()
    
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
        let view: UIView = Bundle.main.loadNibNamed("AddMatchResultView", owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.racePicker.dataSource = self
        self.racePicker.delegate = self
        
        self.racePicker.selectRow(1, inComponent: 0, animated: false)
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 30
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @IBAction func tapOnWin(_ sender: RoundedButton) {
        self.loseButton.alpha = 0.3
        self.winButton.alpha = 1
        
        self.matchResult.resultType = .win
    }
    
    @IBAction func tapOnLose(_ sender: RoundedButton) {
        self.winButton.alpha = 0.3
        self.loseButton.alpha = 1
        
        self.matchResult.resultType = .lose
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.matchResult.vsRace = Race.allRaces[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var racePickerView: RacePickerView
        
        if let reusedView = view as? RacePickerView {
            racePickerView = reusedView
        } else {
            racePickerView = RacePickerView()
        }
        
        let raceImageName = Race.allRaces[row].rawValue
        let raceName = Race.allRaces[row].displayableValue()
        let cellContent = RacePickerViewCellContent.init(raceImageName: raceImageName, raceName: raceName)
        
        racePickerView.displayContent(cellContent)
        
        return racePickerView
    }
}
