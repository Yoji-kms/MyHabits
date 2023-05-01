//
//  HabitsTrackView.swift
//  MyHabits
//
//  Created by Yoji on 15.10.2022.
//

import UIKit

class HabitsTrackView: UIView {
    private lazy var percent: Int = {
        let habits = HabitsStore.shared.habits
        let completed = habits.filter { habit in habit.isAlreadyTakenToday }.count
        return completed / habits.count * 100
    }()
    
    private lazy var justDoItLabel: UILabel = {
        let label = UILabel()
        label.footnoteStatusSetup()
        label.text = NSLocalizedString("You can do it", comment: "Just do it")
        return label
    }()
    
    private lazy var persentLabel: UILabel = {
        let label = UILabel()
        label.footnoteStatusSetup()
        
        label.text = String(self.percent) + "%"
        return label
    }()
    
    private lazy var track: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = UIColor(named: "Purple")
        slider.maximumTrackTintColor = .systemGray2
        
        slider.minimumValue = 0
        slider.maximumValue = 100

        slider.value = Float(self.percent)
        return slider
    }()
}
