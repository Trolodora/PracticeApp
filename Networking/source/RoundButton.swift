//
//  RoundButton.swift
//  Networking
//
//  Created by RomaDUlbich on 8/22/19.
//  Copyright © 2019 Oleg1. All rights reserved.
//

import UIKit

@IBDesignable class RoundButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
             self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
