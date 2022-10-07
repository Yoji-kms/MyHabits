//
//  TabBarController.swift
//  MyHabits
//
//  Created by Yoji on 06.10.2022.
//

import UIKit

class TabBarController: UITabBarController {
    private lazy var habitsNavController: UINavigationController = {
        let navController = UINavigationController(rootViewController: HabitsViewController())
        navController.title = NSLocalizedString("Habits", comment: "Habits")
        navController.tabBarItem.image = UIImage(systemName: "rectangle.grid.1x2.fill")
        return navController
    }()
    
    private lazy var infoNavController: UINavigationController = {
        let navController = UINavigationController(rootViewController: InfoViewController())
        navController.title = NSLocalizedString("Info", comment: "Info")
        navController.tabBarItem.image = UIImage(systemName: "info.circle.fill")
        return navController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    private func setupControllers() {
        self.tabBar.tintColor = UIColor(named: "Purple")
        self.tabBar.barTintColor = .systemGray
        self.viewControllers = [habitsNavController, infoNavController]
    }
}
