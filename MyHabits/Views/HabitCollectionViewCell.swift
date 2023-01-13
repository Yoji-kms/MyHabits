//
//  HabitView.swift
//  MyHabits
//
//  Created by Yoji on 15.10.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.headlineSetup()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.captionSetup()
        return label
    }()
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.footnoteSetup()
        return label
    }()
    
    public lazy var chechbox: Checkbox = {
        let checkbox = Checkbox()
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        return checkbox
    }()
    
    private weak var habit: Habit?
    
    weak var delegate: CheckboxDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
        self.nameLabel.textColor = nil
        self.timeLabel.text = nil
        self.chechbox.tintColor = nil
        self.counterLabel.text = nil
    }
    
    func setup(with viewModel: Habit) {
        self.habit = viewModel
        self.nameLabel.text = viewModel.name
        self.nameLabel.textColor = viewModel.color
        self.timeLabel.text = NSLocalizedString("Every day at", comment: "Every day") + dateFormatter.string(from: viewModel.date)
        self.counterLabel.text = NSLocalizedString("Counter", comment: "Counter") + String(viewModel.trackDates.count)
        self.chechbox.tintColor = viewModel.color
        self.chechbox.isChecked = viewModel.isAlreadyTakenToday
        self.chechbox.isEnabled = !self.chechbox.isChecked
        self.chechbox.addTarget(self, action: #selector(checkboxTap), for: .touchUpInside)
    }
    
    private func setupViews() {
        self.addSubview(self.nameLabel)
        self.addSubview(self.timeLabel)
        self.addSubview(self.chechbox)
        self.addSubview(self.counterLabel)
        
        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -46),
            
            self.timeLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 8),
            self.timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            self.chechbox.widthAnchor.constraint(equalToConstant: 30),
            self.chechbox.heightAnchor.constraint(equalTo: self.chechbox.widthAnchor),
            self.chechbox.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.chechbox.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            self.counterLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.counterLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
        ])
    }
    
    private func updateViews() {
        self.chechbox.isEnabled = false
        self.chechbox.isChecked = true
        self.counterLabel.text = NSLocalizedString("Counter", comment: "Counter") + String(habit?.trackDates.count ?? -1)
    }
    
    @objc private func checkboxTap() {
        print(self.nameLabel.text ?? "no text")

        guard let trackingHabit = habit else {
            print("No habit")
            return
        }
        if !trackingHabit.isAlreadyTakenToday {
            HabitsStore.shared.track(trackingHabit)
            updateViews()
        }
        
        guard let delegate = self.delegate else { return }
        delegate.checkboxTap?()
    }
}

