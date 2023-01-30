//
//  HabitDatesTableHeader.swift
//  MyHabits
//
//  Created by Yoji on 29.01.2023.
//

import UIKit

class HabitDatesTableHeader: UITableViewHeaderFooterView {
    private lazy var headerLabel: UILabel = {
        let lbl = UILabel()
        lbl.footnoteSetup()
        lbl.text = NSLocalizedString("Activity", comment: "Activity")
        return lbl
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            self.headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 22),
            self.headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
        ])
    }
}
