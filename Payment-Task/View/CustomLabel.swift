//
//  CustomLabel.swift
//  Payment-Task
//
//  Created by Macbook on 24.10.2017.
//  Copyright © 2017 Yigit Yilmaz. All rights reserved.
//

import UIKit

open class CustomLabel : UILabel {
    @IBInspectable open var characterSpacing:CGFloat = 1 {
        didSet {
            let attributedString = NSMutableAttributedString(string: self.text!)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: self.characterSpacing, range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString
        }
        
    }
}
