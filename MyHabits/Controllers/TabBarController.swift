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
        
        return navController
    }()
    
    private lazy var infoNavController: UINavigationController = {
        let navController = UINavigationController(rootViewController: InfoViewController())
        
        return navController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    private func setupControllers() {
        self.viewControllers = [habitsNavController, infoNavController]
    }
}
