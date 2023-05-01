//
//  HabitDatesTableViewCell.swift
//  MyHabits
//
//  Created by Yoji on 26.01.2023.
//

import UIKit

final class HabitDatesTableViewCell: UITableViewCell {
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.bodySetup()
        return label
    }()
    
    private lazy var checkImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.tintColor = UIColor(named: "Purple")
        imgView.image = UIImage(systemName: "checkmark")
        imgView.isHidden = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        dateLabel.text = nil
        checkImageView.isHidden = false
    }
    
    func setup(date: Date, isChecked: Bool) {
        dateLabel.text = date.formateDate()
        checkImageView.isHidden = !isChecked
    }
    
    private func setupViews() {
        self.addSubview(dateLabel)
        self.addSubview(checkImageView)
        
        NSLayoutConstraint.activate([
            self.dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            self.dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
            self.checkImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.checkImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
}

extension Date {
    func formateDate() -> String {
        let now = Date.now
        let calendar = NSCalendar.current
        
        switch calendar.numberOfDaysBetween(self, and: now) {
        case 1: return NSLocalizedString("Yesterday", comment: "Yesterday")
        case 2: return NSLocalizedString("The day before yesterday", comment: "The day before yesterday")
        default: return self.formatted(date: .long, time: .omitted)
        }
    }
}

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
            let fromDate = startOfDay(for: from) // <1>
            let toDate = startOfDay(for: to) // <2>
            let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
            
            return numberOfDays.day!
        }
}
