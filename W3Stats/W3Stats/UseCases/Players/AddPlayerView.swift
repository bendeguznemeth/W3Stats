//
//  AddPlayerView.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 13..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import UIKit

protocol AddPlayerDelegate {
    func addNewPlayer(_ playerResult: AddPlayerView.NewPlayer)
}

class AddPlayerView: UIView {
    
    struct NewPlayer {
        var name: String
        var race: Race
        
        init() {
            self.name = ""
            self.race = .human
        }
    }
    
    @IBOutlet weak var racePicker: UIPickerView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    private var playerResult = NewPlayer()
    
    var delegate: AddPlayerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        let view: UIView = Bundle.main.loadNibNamed("AddPlayerView", owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.racePicker.dataSource = self
        self.racePicker.delegate = self
        
        self.nameTextField.delegate = self
        
        self.racePicker.selectRow(1, inComponent: 0, animated: false)
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 30
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.nameTextField.layer.cornerRadius = 20
        self.nameTextField.layer.borderWidth = 0.25
        self.nameTextField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        guard let name = self.nameTextField.text else {
            return
        }
        
        self.playerResult.name = name
        
        self.saveButton.isEnabled = self.isCorrectName(name)
    }
    
    @IBAction func tapOnSave(_ sender: UIButton) {
        self.nameTextField.resignFirstResponder()
        
        self.delegate?.addNewPlayer(self.playerResult)
        self.nameTextField.text = nil
    }
    
    private func isCorrectName(_ name: String) -> Bool {
        return name.count >= 3 ? true : false
    }
}

extension AddPlayerView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Race.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.playerResult.race = Race.allRaces[row]
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

extension AddPlayerView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.nameTextField.resignFirstResponder()
        return true
    }
    
    
}
