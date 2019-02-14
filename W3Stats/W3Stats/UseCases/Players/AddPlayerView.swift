//
//  AddPlayerView.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 13..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import UIKit

protocol AddPlayerDelegate {
    func addNewPlayer(_ playerResult: PlayerResult)
}

struct PlayerResult {
    var name: String?
    var species: Species
}

class AddPlayerView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var speciesPickerView: UIPickerView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    private var playerResult = PlayerResult(name: nil, species: .human)
    
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
        Bundle.main.loadNibNamed("AddPlayerView", owner: self, options: nil)
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.speciesPickerView.dataSource = self
        self.speciesPickerView.delegate = self
        
        self.nameTextField.delegate = self
        
        self.speciesPickerView.selectRow(1, inComponent: 0, animated: false)
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
        return Species.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Species.allSpecies[row].displayableValue()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.playerResult.species = Species.allSpecies[row]
    }
}

extension AddPlayerView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.nameTextField.resignFirstResponder()
        return true
    }
    
    
}
