//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Yoji on 08.10.2022.
//

import UIKit

class HabitViewController:UIViewController {
//    MARK: Views
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    private lazy var cancelBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.title = NSLocalizedString("Cancel", comment: "Cancel")
        btn.target = self
        btn.action = #selector(cancelBtnTap)
        btn.tintColor = UIColor(named: "Purple")
        return btn
    }()
    
    private lazy var saveBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.title = NSLocalizedString("Save", comment: "Save")
        btn.target = self
        btn.action = #selector(saveBtnTap)
        btn.tintColor = UIColor(named: "Purple")
        btn.isEnabled = false
        return btn
    }()
    
    private lazy var borderView: UIView = {
        let borderView = UIView()
        borderView.backgroundColor = .lightGray
        borderView.translatesAutoresizingMaskIntoConstraints = false
        return borderView
    }()
    
    private lazy var backgroundView: UIView = {
        let basicView = UIView()
        basicView.backgroundColor = .white
        basicView.translatesAutoresizingMaskIntoConstraints = false
        return basicView
    }()
    
    private lazy var backgroundViewWihPadding: UIView = {
        let basicView = UIView()
        basicView.backgroundColor = .white
        basicView.translatesAutoresizingMaskIntoConstraints = false
        return basicView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Title", comment: "Title")
        label.footnoteCapsSetup()
        return label
    }()
    
    private lazy var txtView: UITextView = {
        let txtView = UITextView()
        txtView.text = NSLocalizedString("Run in the morning...", comment: "Run...")
        txtView.bodySetup()
        txtView.delegate = self
        return txtView
    }()
    
    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Color", comment: "Color")
        label.footnoteCapsSetup()
        return label
    }()
    
    private lazy var colorCircleBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(named: "Orange")
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(colorCircleTap), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Time", comment: "Time")
        label.footnoteCapsSetup()
        return label
    }()
    
    private lazy var time: String = {
        let str = dateFormatter.string(from: self.timePicker.date)
        return str
    }()
    
    private lazy var everyDayLabel: UILabel = {
        let label = UILabel()
        label.bodySetup()
        label.attributedText = getAttributedEveryDayString()
        return label
    }()
    
    private lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.timeZone = .autoupdatingCurrent
        picker.preferredDatePickerStyle = .wheels
        picker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    weak var delegate: UpdateScreenDelegate?
    
//    MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "Light Gray")
    
        setupNavController()
        setupViews()
        setupGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
//    MARK: Setups
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func setupViews() {
        self.view.addSubview(self.borderView)
        self.view.addSubview(self.backgroundView)
        self.backgroundView.addSubview(self.backgroundViewWihPadding)
        
        self.backgroundViewWihPadding.addSubview(self.titleLabel)
        self.backgroundViewWihPadding.addSubview(self.txtView)
        self.backgroundViewWihPadding.addSubview(self.colorLabel)
        self.backgroundViewWihPadding.addSubview(self.colorCircleBtn)
        self.backgroundViewWihPadding.addSubview(self.timeLabel)
        self.backgroundViewWihPadding.addSubview(self.everyDayLabel)
        self.backgroundViewWihPadding.addSubview(self.timePicker)
        
        NSLayoutConstraint.activate([
            self.borderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.borderView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.borderView.heightAnchor.constraint(equalToConstant: 1),
            
            self.backgroundView.topAnchor.constraint(equalTo: self.borderView.bottomAnchor),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.backgroundView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
            
            self.backgroundViewWihPadding.heightAnchor.constraint(equalTo: self.backgroundView.heightAnchor),
            self.backgroundViewWihPadding.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor, constant: 16),
            self.backgroundViewWihPadding.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: -16),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.backgroundViewWihPadding.topAnchor, constant: 20),
            self.titleLabel.widthAnchor.constraint(equalTo: self.backgroundViewWihPadding.widthAnchor),
            
            self.txtView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            self.txtView.widthAnchor.constraint(equalTo: self.backgroundViewWihPadding.widthAnchor),
            
            self.colorLabel.topAnchor.constraint(equalTo: self.txtView.bottomAnchor, constant: 24),
            self.colorLabel.widthAnchor.constraint(equalTo: self.backgroundViewWihPadding.widthAnchor),
            
            self.colorCircleBtn.topAnchor.constraint(equalTo: self.colorLabel.bottomAnchor, constant: 8),
            self.colorCircleBtn.heightAnchor.constraint(equalToConstant: 30),
            self.colorCircleBtn.widthAnchor.constraint(equalTo: self.colorCircleBtn.heightAnchor),
            
            self.timeLabel.topAnchor.constraint(equalTo: self.colorCircleBtn.bottomAnchor, constant: 24),
            self.timeLabel.widthAnchor.constraint(equalTo: self.backgroundViewWihPadding.widthAnchor),
            
            self.everyDayLabel.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 8),
            self.everyDayLabel.widthAnchor.constraint(equalTo: self.backgroundViewWihPadding.widthAnchor),

            self.timePicker.topAnchor.constraint(equalTo: self.everyDayLabel.bottomAnchor, constant: 8),
            self.timePicker.widthAnchor.constraint(equalTo: self.backgroundViewWihPadding.widthAnchor),
        ])
    }
    
    private func setupNavController() {
        self.navigationItem.leftBarButtonItem = self.cancelBtn
        self.navigationItem.title = NSLocalizedString("Create", comment: "Create")
        self.navigationItem.rightBarButtonItem = self.saveBtn
    }
    
//    MARK: Attributing
    private func getAttributedEveryDayString() -> NSMutableAttributedString {
        let string = NSLocalizedString("Every day at", comment: "Every day") + time
        let range = (string as NSString).range(of: time)
        let attributedString = NSMutableAttributedString.init(string: string)
        
        attributedString.addAttribute(.foregroundColor, value: UIColor(named: "Purple") ?? .black, range: range)

        return attributedString
    }
    
//    MARK: Actions
    @objc private func cancelBtnTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveBtnTap() {
        let savingHabit = Habit(
            name: txtView.text,
            date: timePicker.date,
            color: colorCircleBtn.backgroundColor ?? .systemOrange
        )
        let store = HabitsStore.shared
        store.habits.append(savingHabit)
        navigationController?.popViewController(animated: true)
        guard let delegate = self.delegate else {
            return
        }
        print(store.todayProgress * 100)

        delegate.updateScreen?()
    }
    
    @objc private func colorCircleTap() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.selectedColor = self.colorCircleBtn.backgroundColor ?? .white
        colorPicker.delegate = self
        self.navigationController?.present(colorPicker, animated: true, completion:nil)
    }
    
    @objc private func timeChanged() {
        time = dateFormatter.string(from: self.timePicker.date)
        everyDayLabel.attributedText = getAttributedEveryDayString()
    }
    
    @objc private func didHideKeyboard(_ notification: Notification) {
        self.forcedHidingKeyboard()
    }
    
    @objc private func forcedHidingKeyboard() {
        self.view.endEditing(true)
    }
}

//MARK: Extensions
extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.colorCircleBtn.backgroundColor = viewController.selectedColor
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.colorCircleBtn.backgroundColor = viewController.selectedColor
    }
}

extension HabitViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.textColor == UIColor.lightGray && textView.isFirstResponder) {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == "" {
            textView.textColor = .lightGray
            textView.text = NSLocalizedString("Run in the morning...", comment: "Run...")
        } else {
            self.saveBtn.isEnabled = true
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == "" {
            self.saveBtn.isEnabled = false
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text.rangeOfCharacter(from: CharacterSet.newlines) == nil else {
            return false
        }
        return true
    }
}

