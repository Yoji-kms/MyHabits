//
//  HabitsTrackView.swift
//  MyHabits
//
//  Created by Yoji on 15.10.2022.
//

import UIKit

final class ProgressCollectionViewCell: UICollectionViewCell {
    private lazy var justDoItLabel: UILabel = {
        let label = UILabel()
        label.footnoteStatusSetup()
        label.text = NSLocalizedString("You can do it", comment: "Just do it")
        return label
    }()
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.footnoteStatusSetup()
        label.text = progressText()
        return label
    }()
    
    private lazy var progressSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = UIColor(named: "Purple")
        slider.maximumTrackTintColor = .systemGray2
        slider.isEnabled = false
        slider.setThumbImage(UIImage(), for: .normal)
        slider.value = HabitsStore.shared.todayProgress
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.progressLabel.text = progressText()
        self.progressSlider.value = HabitsStore.shared.todayProgress
    }
    
    private func progressText() -> String {
        let progress = Int(HabitsStore.shared.todayProgress * 100)
        return String(progress) + "%"
    }
    
    private func setupViews() {
        self.addSubview(justDoItLabel)
        self.addSubview(progressLabel)
        self.addSubview(progressSlider)
        
        NSLayoutConstraint.activate([
            self.justDoItLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 12),
            self.justDoItLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            
            self.progressLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            self.progressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),

            self.progressSlider.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -24),
            self.progressSlider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.progressSlider.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
}
