//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Yoji on 26.01.2023.
//

import UIKit

final class HabitDetailsViewController: UIViewController {
    private var habit: Habit?
    let dates = HabitsStore.shared.dates
    weak var delegate: UpdateScreenDelegate?
    
    private lazy var habitDatesTableView: UITableView = {
        let tblView = UITableView()
        tblView.backgroundColor = UIColor(named: "Light Gray")
        tblView.register(HabitDatesTableViewCell.self, forCellReuseIdentifier: "HabitDatesTableViewCell")
        tblView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tblView.register(HabitDatesTableHeader.self, forHeaderFooterViewReuseIdentifier: "HabitDatesTableHeader")
        tblView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "DefaultHeader")
        tblView.dataSource = self
        tblView.delegate = self
        tblView.translatesAutoresizingMaskIntoConstraints = false
        
        return tblView
    }()
    
    private lazy var editBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.title = NSLocalizedString("Edit", comment: "Edit")
        btn.target = self
        btn.action = #selector(editBtnTap)
        btn.tintColor = UIColor(named: "Purple")
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupView()
        setupNavController()
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
    
    
    private func setupNavController() {
        self.navigationController?.navigationBar.tintColor = UIColor(named: "Purple")
        self.navigationItem.rightBarButtonItem = self.editBtn
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setup(with viewModel: Habit){
        self.navigationItem.title = viewModel.name
        self.habit = viewModel
    }
    
    @objc private func editBtnTap() {
        let habitVC = HabitViewController()
        guard let habit = self.habit else {
            return
        }

        habitVC.setup(with: habit)
        habitVC.updateScreenDelegate = self.delegate
        habitVC.updateTitleDelegate = self
        self.navigationController?.pushViewController(habitVC, animated: true)
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
}

extension HabitDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HabitDatesTableHeader") as? HabitDatesTableHeader
        else {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DefaultHeader")
            return header
        }
        
        return header
    }
}

extension HabitDetailsViewController: UpdateTitleDelegate {
    func updateTitle(newHabit: Habit) {
        self.habit = newHabit
        self.navigationItem.title = newHabit.name
    }
}

