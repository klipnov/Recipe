//
//  PickerViewTableViewCell.swift
//  recipeApp
//
//  Created by Shah Qays on 22/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit

class RecipeTypesPickerViewTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    let recipeTypes = RecipeTypes()
    var didSelectRow: ((String)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return recipeTypes.types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return recipeTypes.types[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedString = recipeTypes.types[row]
        didSelectRow?(selectedString)
    }
}
