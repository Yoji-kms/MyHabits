//
//  TextUtils.swift
//  MyHabits
//
//  Created by Yoji on 10.10.2022.
//

import UIKit

extension UILabel {
    func titleSetup() {
        self.textColor = .black
        self.font = .systemFont(ofSize: 20, weight: .semibold)
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func headlineSetup() {
        self.textColor = .black
        self.font = .systemFont(ofSize: 17, weight: .semibold)
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func bodySetup() {
        self.textColor = .black
        self.font = .systemFont(ofSize: 17, weight: .regular)
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func footnoteCapsSetup() {
        self.textColor = .black
        self.font = .systemFont(ofSize: 13, weight: .semibold)
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func footnoteStatusSetup() {
        self.textColor = .black
        self.font = .systemFont(ofSize: 13, weight: .semibold)
        self.alpha = 0.5
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func footnoteSetup() {
        self.textColor = .systemGray
        self.font = .systemFont(ofSize: 13, weight: .regular)
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func captionSetup() {
        self.textColor = .systemGray2
        self.font = .systemFont(ofSize: 12, weight: .regular)
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UITextView {
    func bodySetup() {
        self.enablesReturnKeyAutomatically = true
        self.textColor = .lightGray
        self.font = .systemFont(ofSize: 17, weight: .regular)
        self.backgroundColor = UIColor(named: "Light Gray")
        self.isEditable = true
        self.isScrollEnabled = false
        self.textContainer.maximumNumberOfLines = 2
        self.textContainer.lineBreakMode = .byClipping
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}


