//
//  HabitUtils.swift
//  MyHabits
//
//  Created by Yoji on 16.02.2023.
//

import Foundation

extension Habit {
    func getIndexPath() -> IndexPath? {
        guard let row = HabitsStore.shared.habits.firstIndex(of: self) else { return nil }
        return IndexPath(row: row, section: 1)
    }
}
