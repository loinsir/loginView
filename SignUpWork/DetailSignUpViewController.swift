//
//  DetailSignUpViewController.swift
//  SignUpWork
//
//  Created by 김인환 on 2021/08/02.
//

import UIKit

class DetailSignUpViewController: UIViewController {
    
//    MARK: - IBOutlet
    @IBOutlet var phoneNumField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!

//    MARK: - Subviews
    func addSubViews() {
        self.addPhoneNumberField()
//        self.addDatePicker()
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
        fieldStack.alignment = .leading
        fieldStack.distribution = .equalSpacing
        
        self.view.addSubview(fieldStack)
        fieldStack.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX: NSLayoutConstraint
        centerX = fieldStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let top: NSLayoutConstraint
        top = fieldStack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        
        let width: NSLayoutConstraint
        width = fieldStack.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
        
        centerX.isActive = true
        top.isActive = true
        width.isActive = true
        
        self.phoneNumField = phoneNumberField
    }
    
    func addDatePicker() {
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        
        self.view.addSubview(datePicker)
        
        self.datePicker = datePicker
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
