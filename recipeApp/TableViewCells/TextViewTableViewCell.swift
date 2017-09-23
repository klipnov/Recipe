//
//  TextViewTableViewCell.swift
//  recipeApp
//
//  Created by Shah Qays on 22/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit

class TextViewTableViewCell: UITableViewCell, UITextViewDelegate {

    
    @IBOutlet weak var textView: UITextView!
    var placeholderText: String?
    var didEndEditing: ((String)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self
    }
    
    func updateCellPlaceholder(string: String) {
        placeholderText = string
        
        if textView.text == "" || textView.text.count < 1 {
            textView.text = placeholderText
        } 
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text != placeholderText {
            didEndEditing?(textView.text)
        }
    }
}
