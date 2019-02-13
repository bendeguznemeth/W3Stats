//
//  AddMatchResultView.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 12..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import UIKit

class AddMatchResultView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var speciesPickerView: UIPickerView!
    
    private let pickerContent: [Species] = [.elf, .human, .orc, .undead]
    
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
        
        self.speciesPickerView.dataSource = self
        self.speciesPickerView.delegate = self
        
        self.speciesPickerView.selectRow(1, inComponent: 0, animated: false)
    }
    
    @IBAction func tapOnWin(_ sender: UITapGestureRecognizer) {
        print("tapOnWin")
    }
    
    @IBAction func tapOnLose(_ sender: UITapGestureRecognizer) {
        print("tapOnLose")
    }
    
    @IBAction func tapOnSave(_ sender: UIButton) {
        print("tapOnSave")
    }
}

extension AddMatchResultView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Species.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerContent[row].displayableValue()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("\(row)")
    }
}
