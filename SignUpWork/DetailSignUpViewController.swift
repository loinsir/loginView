//
//  DetailSignUpViewController.swift
//  SignUpWork
//
//  Created by 김인환 on 2021/08/02.
//

import UIKit

class DetailSignUpViewController: UIViewController, UIGestureRecognizerDelegate {
    
//    MARK: - Properties
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, YYYY"
        return formatter
    }()
    
    var datePickerLabel: UILabel!
    var phoneNumberField: UITextField!
    
//    MARK: - IBOutlet
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var prevButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    
//    MARK: - IBAction
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate: Date = self.datePicker.date
        self.datePickerLabel.text = self.dateFormatter.string(from: selectedDate)
    }
    
    @IBAction func touchCancelButton(_ sender: UIButton) {
        UserInformation.shared.clearFields()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchPrevButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchSignUpButton(_ sender: UIButton) {
        UserInformation.shared.phoneNumber = self.phoneNumberField.text
        UserInformation.shared.birthDay = self.datePicker.date
        
        self.presentingViewController?.viewDidLoad()
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmButtonState(_ sender: UIView) {
        if phoneNumberField.text != "" {
            self.signUpButton.isEnabled = true
        } else {
            self.signUpButton.isEnabled = false
        }
    }
    
//    MARK: - Gesture Recognizer
    func addGestureRecognizer() {
        let gestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.delegate = self
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
    }

//    MARK: - Subviews
    func addSubViews() {
        self.addPhoneNumberField()
        self.addDatePicker()
        self.addButtons()
    }
    
    func addPhoneNumberField() {
        let phoneNumberLabel: UILabel = UILabel()
        phoneNumberLabel.text = "전화번호"
        
        let phoneNumberField: UITextField = UITextField()
        phoneNumberField.borderStyle = .roundedRect
        phoneNumberField.keyboardType = .phonePad
        
        let fieldStack: UIStackView = UIStackView(arrangedSubviews: [phoneNumberLabel, phoneNumberField])
        fieldStack.axis = .vertical
        fieldStack.spacing = 10.0
        fieldStack.alignment = .fill
        
        self.view.addSubview(fieldStack)
        fieldStack.translatesAutoresizingMaskIntoConstraints = false
        
        let top: NSLayoutConstraint
        top = fieldStack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10.0)
        
        let centerX: NSLayoutConstraint
        centerX = fieldStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let width: NSLayoutConstraint
        width = fieldStack.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
        
        phoneNumberField.addTarget(self, action: #selector(confirmButtonState(_:)), for: .editingChanged)
        
        top.isActive = true
        centerX.isActive = true
        width.isActive = true
        
        self.phoneNumberField = phoneNumberField
    }
    
    func addDatePicker() {
        let birthLabel: UILabel = UILabel()
        
        let datePicker: UIDatePicker = {
            let picker = UIDatePicker()
            picker.preferredDatePickerStyle = .wheels
            picker.datePickerMode = .date
            return picker
        }()
        
        let datePickerLabel: UILabel = {
            let dateLabel = UILabel()
            dateLabel.text = self.dateFormatter.string(from: datePicker.date)
            return dateLabel
        }()
        
        birthLabel.text = "생년월일"

        let labelStack: UIStackView = UIStackView(arrangedSubviews: [birthLabel, datePickerLabel])
        labelStack.axis = .horizontal
        labelStack.distribution = .equalSpacing
        
        let pickerStack: UIStackView = UIStackView(arrangedSubviews: [labelStack, datePicker])
        pickerStack.axis = .vertical
        
        self.view.addSubview(pickerStack)
        pickerStack.translatesAutoresizingMaskIntoConstraints = false
        
    
        let top: NSLayoutConstraint
        top = pickerStack.topAnchor.constraint(equalTo: self.phoneNumberField.bottomAnchor, constant: 10.0)
        
        let width: NSLayoutConstraint
        width = pickerStack.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
        
        let centerX: NSLayoutConstraint
        centerX = pickerStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        top.isActive = true
        width.isActive = true
        centerX.isActive = true
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        self.datePicker = datePicker
        self.datePickerLabel = datePickerLabel
    }
    
    func addButtons() {
        let cancelButton: UIButton = {
            let button = UIButton()
            button.setTitle("취소", for: .normal)
            button.setTitleColor(.systemRed, for: .normal)
            button.setTitleColor(.opaqueSeparator, for: .highlighted)
            return button
        }()
        
        let prevButton: UIButton = {
            let button = UIButton()
            button.setTitle("이전", for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            button.setTitleColor(.opaqueSeparator, for: .highlighted)
            return button
        }()
        
        let signUpButton: UIButton = {
            let button = UIButton()
            button.setTitle("가입", for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            button.setTitleColor(.opaqueSeparator, for: .highlighted)
            button.setTitleColor(.opaqueSeparator, for: .disabled)
            button.isEnabled = false // default state
            return button
        }()
        
        let buttonStack: UIStackView = UIStackView(arrangedSubviews: [cancelButton, prevButton, signUpButton])
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        
        self.view.addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX: NSLayoutConstraint
        centerX = buttonStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let top: NSLayoutConstraint
        top = buttonStack.topAnchor.constraint(equalTo: self.datePicker.bottomAnchor, constant: 13.0)
        
        let width: NSLayoutConstraint
        width = buttonStack.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        
        centerX.isActive = true
        top.isActive = true
        width.isActive = true
        
        cancelButton.addTarget(self, action: #selector(touchCancelButton(_:)), for: .touchUpInside)
        prevButton.addTarget(self, action: #selector(touchPrevButton(_:)), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(touchSignUpButton(_:)), for: .touchUpInside)
        
        self.cancelButton = cancelButton
        self.prevButton = prevButton
        self.signUpButton = signUpButton
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        self.addGestureRecognizer()
        self.addSubViews()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
