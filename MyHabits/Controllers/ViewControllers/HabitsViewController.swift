//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Yoji on 06.10.2022.
//

import UIKit

class HabitsViewController: UIViewController {
//    MARK: Views
    private lazy var addBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = UIImage(systemName: "plus")
        btn.tintColor = UIColor(named: "Purple")
        btn.target = self
        btn.action = #selector(tapAddBtn)
        return btn
    }()
    
    private lazy var habitLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var habitsCollectionView: UICollectionView = {
        let colView = UICollectionView(frame: .zero, collectionViewLayout: self.habitLayout)
        colView.delegate = self
        colView.dataSource = self
        colView.backgroundColor = .lightGray
        colView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "ProgressCellId")
        colView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "HabitCellId")
        colView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCellId")
        colView.translatesAutoresizingMaskIntoConstraints = false
        colView.largeContentTitle = NSLocalizedString("Today", comment: "Today")
        return colView
    }()
    
//  MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "Light Gray")
        self.navigationItem.rightBarButtonItem = addBtn
        self.navigationItem.title = NSLocalizedString("Today", comment: "Today")
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.updateProgress()
    }
    
    private func setupViews() {
        self.view.addSubview(habitsCollectionView)
        
        NSLayoutConstraint.activate([
            self.habitsCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.habitsCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.habitsCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.habitsCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
//    MARK: Actions
    @objc private func tapAddBtn() {
        let habitVC = HabitViewController()
        habitVC.modalTransitionStyle = .coverVertical
        habitVC.modalPresentationStyle = .popover
        habitVC.delegate = self
           
        self.navigationController?.pushViewController(habitVC, animated: true)
    }

    private func updateProgress() {
        let index = IndexPath(row: 0, section: 0)
        self.habitsCollectionView.reloadItems(at: [index])
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = {
            switch indexPath.section {
            case 1: return HabitsStore.shared.habits[indexPath.row].name.count > 25 ? 160 : 130
            default: return 60
            }
        }()
        
        return CGSize(width: UIScreen.main.bounds.width - 16, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let progressCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressCellId", for: indexPath) as? ProgressCollectionViewCell else {
            let progressCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCellId", for: indexPath)
            return progressCell
        }

        if indexPath.section == 0 {
            return progressCell
        }
        
        guard let habitCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitCellId", for: indexPath) as? HabitCollectionViewCell else {
            let habitCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCellId", for: indexPath)
            return habitCell
        }
        
        habitCell.setup(with: HabitsStore.shared.habits[indexPath.row])
        habitCell.delegate = self
        
        return habitCell
    }
}

extension HabitsViewController: CheckboxDelegate {
    func checkboxTap() {
        updateProgress()
    }
}
extension HabitsViewController: UpdateScreenDelegate {
    func updateScreen() {
        self.habitsCollectionView.reloadSections(IndexSet(integer: 1))
        updateProgress()
    }
}
