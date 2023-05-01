//
//  UpdateTitleDelegate.swift
//  MyHabits
//
//  Created by Yoji on 30.01.2023.
//

import Foundation

protocol UpdateTitleDelegate: AnyObject {
    func updateTitle(newHabit: Habit)
}
