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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self
        textView.text = placeholderText
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text != placeholderText {
            print("Text is changed")
        }
    }
}
