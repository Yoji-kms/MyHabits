//
//  HabitView.swift
//  MyHabits
//
//  Created by Yoji on 15.10.2022.
//

import UIKit

class HabitView: UIView {
    private var habit: Habit
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    init(habit habitItem: Habit) {
        self.habit = habitItem
        super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.headlineSetup()
        label.text = habit.name
        label.textColor = habit.color
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.captionSetup()
        label.text = NSLocalizedString("Every day at", comment: "Every day") + dateFormatter.string(from: habit.date)
        return label
    }()
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.footnoteSetup()
        label.text = NSLocalizedString("Counter", comment: "Counter")
        return label
    }()
    
    private lazy var chechbox: UISwitch = {
        let checkbox = UISwitch()
        checkbox.onImage = UIImage(named: "checkmark.circle.fill")
        checkbox.offImage = UIImage(named: "circle")
        checkbox.backgroundColor = self.habit.color
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        return checkbox
    }()
}
