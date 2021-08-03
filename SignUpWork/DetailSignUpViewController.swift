//
//  DetailSignUpViewController.swift
//  SignUpWork
//
//  Created by 김인환 on 2021/08/02.
//

import UIKit

class DetailSignUpViewController: UIViewController {
    
//    MARK: - Properties
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, YYYY"
        return formatter
    }()
    
    var datePickerLabel: UILabel!
    var phoneNumber: UITextField!
    
//    MARK: - IBOutlet
    @IBOutlet var datePicker: UIDatePicker!
    
//    MARK: - IBAction
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate:Date = self.datePicker.date
        self.datePickerLabel.text = self.dateFormatter.string(from: selectedDate)
    }

//    MARK: - Subviews
    func addSubViews() {
        self.addPhoneNumberField()
        self.addDatePicker()
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
        
        top.isActive = true
        centerX.isActive = true
        width.isActive = true
        
        self.phoneNumber = phoneNumberField
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
        top = pickerStack.topAnchor.constraint(equalTo: self.phoneNumber.bottomAnchor, constant: 10.0)
        
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
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
