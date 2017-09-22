//
//  TextFieldTableViewCell.swift
//  recipeApp
//
//  Created by Shah Qays on 22/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    var didUpdateTextfield: ((String?)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        didUpdateTextfield?(textField.text)
    }
}
