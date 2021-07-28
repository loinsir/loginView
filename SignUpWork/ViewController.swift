//
//  ViewController.swift
//  SignUpWork
//
//  Created by 김인환 on 2021/07/28.
//

import UIKit

class ViewController: UIViewController {
    
//    MARK: - Properties
    var loginImageView: UIImageView!
    
//    MARK: - IBOutlet
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    
//    MARK: - Subviews
    func addSubViews() {
        self.addLoginImageView()
        self.addTextField()
    }
    
    func addLoginImageView() {
        
        let loginImageView: UIImageView = UIImageView(image: UIImage(named: "loginIcon.png"))
        self.view.addSubview(loginImageView)
        loginImageView.translatesAutoresizingMaskIntoConstraints = false
        loginImageView.contentMode = UIView.ContentMode.scaleAspectFit
        
        let centerX: NSLayoutConstraint
        centerX = loginImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let centerY: NSLayoutConstraint
        centerY = NSLayoutConstraint(item: loginImageView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 0.45, constant: 0.0)
        
        let width: NSLayoutConstraint
        width = loginImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)
        
        let ratio: NSLayoutConstraint
        ratio = NSLayoutConstraint(item: loginImageView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: loginImageView, attribute: NSLayoutConstraint.Attribute.width, multiplier: 0.5, constant: 0.0)
        
        centerX.isActive = true
        centerY.isActive = true
        width.isActive = true
        ratio.isActive = true
        
        self.loginImageView = loginImageView
    }
    
    func addTextField() {
        let idTextField: UITextField = UITextField()
        let pwTextField: UITextField = UITextField()
        let fieldStack: UIStackView = UIStackView()
        
        idTextField.placeholder = "ID"
        pwTextField.placeholder = "Password"
        
        idTextField.borderStyle = .roundedRect
        pwTextField.borderStyle = .roundedRect
        
        fieldStack.alignment = .fill
        fieldStack.axis = .vertical
        fieldStack.addArrangedSubview(idTextField)
        fieldStack.addArrangedSubview(pwTextField)
        fieldStack.spacing = 15.0
        
        self.view.addSubview(fieldStack)
        fieldStack.translatesAutoresizingMaskIntoConstraints = false

        let centerX: NSLayoutConstraint
        centerX = fieldStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let top: NSLayoutConstraint
        top = fieldStack.topAnchor.constraint(equalTo: self.loginImageView.bottomAnchor, constant: 30)
        
        let width: NSLayoutConstraint
        width = NSLayoutConstraint(item: fieldStack, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.width, multiplier: 0.7, constant: 0.0)
        
        centerX.isActive = true
        top.isActive = true
        width.isActive = true
        
    }

//    MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubViews()
        // Do any additional setup after loading the view.
    }


}

