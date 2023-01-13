//
//  Checkbox.swift
//  MyHabits
//
//  Created by Yoji on 23.10.2022.
//

import UIKit

class Checkbox: UIButton {
    let checkedImage = UIImage(systemName: "checkmark.circle.fill")
    let uncheckedImage = UIImage(systemName: "circle")
        
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setBackgroundImage(self.checkedImage, for: .normal)
                self.setBackgroundImage(self.checkedImage, for: .disabled)

            } else {
                self.setBackgroundImage(self.uncheckedImage, for: .normal)
            }
        }
    }
}
