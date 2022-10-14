//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Yoji on 06.10.2022.
//

import UIKit

class HabitsViewController: UIViewController {
    private lazy var addBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = UIImage(systemName: "plus")
        btn.tintColor = UIColor(named: "Purple")
        btn.target = self
        btn.action = #selector(tapBtn)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "Light Gray")
        self.navigationItem.rightBarButtonItem = addBtn
        
        setupViews()
    }
    
    private func setupViews() {
        
    }
    
    @objc private func tapBtn() {
        let habitVC = HabitViewController()
        habitVC.modalTransitionStyle = .coverVertical
        habitVC.modalPresentationStyle = .popover
        let havitNC = UINavigationController(rootViewController: habitVC)
        
        self.navigationController?.present(havitNC, animated: true, completion: nil)
    }
}
