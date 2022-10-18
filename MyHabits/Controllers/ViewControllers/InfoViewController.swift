//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Yoji on 06.10.2022.
//

import UIKit

class InfoViewController: UIViewController {
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.layer.borderColor = UIColor.lightGray.cgColor
        scroll.layer.borderWidth = 1
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Info title", comment: "Info title")
        label.titleSetup()
        return label
    }()
    
    private lazy var stepsLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Steps", comment: "Steps")
        label.bodySetup()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = NSLocalizedString("Info", comment: "Info")
        self.view.backgroundColor = UIColor(named: "Light Gray")
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(self.scrollView)
        
        self.scrollView.addSubview(stackView)
        
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.stepsLabel)
        
        self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),

            self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 22),
            self.stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}
