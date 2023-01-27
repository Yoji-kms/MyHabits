//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Yoji on 26.01.2023.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    var habit: Habit?
    let dates = HabitsStore.shared.dates
    private lazy var habitDatesTableView: UITableView = {
        let tblView = UITableView()
        tblView.register(HabitDatesTableViewCell.self, forCellReuseIdentifier: "HabitDatesTableViewCell")
        tblView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tblView.dataSource = self
        tblView.translatesAutoresizingMaskIntoConstraints = false
        
        return tblView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        self.view.addSubview(self.habitDatesTableView)
        
        NSLayoutConstraint.activate([
            self.habitDatesTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.habitDatesTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.habitDatesTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.habitDatesTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dates.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
                habitDatesTableView.dequeueReusableCell(withIdentifier: "HabitDatesTableViewCell", for: indexPath) as? HabitDatesTableViewCell else {
            let cell = habitDatesTableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        if let habit = self.habit {
            let date = self.dates[self.dates.count - 2 - indexPath.row]
            cell.setup(date: date, isChecked: HabitsStore.shared.habit(habit, isTrackedIn: date))
        }
        cell.clipsToBounds = true
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
