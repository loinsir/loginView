//
//  ViewController.swift
//  SignUpWork
//
//
//

import UIKit

class ViewController: UIViewController {
    
//    MARK: - Properties
    var loginImageView: UIImageView!
    var inputFieldStack: UIStackView!
    
//    MARK: - IBOutlet
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    
//    MARK: - Subviews
    func addSubViews() {
        self.addTextField()
        self.addLoginImageView()
    }
    
    func addLoginImageView() {
        
        let loginImageView: UIImageView = UIImageView(image: UIImage(named: "loginIcon.png"))
        self.view.addSubview(loginImageView)
        loginImageView.translatesAutoresizingMaskIntoConstraints = false
        loginImageView.contentMode = UIView.ContentMode.scaleAspectFit
        
        let centerX: NSLayoutConstraint
        centerX = loginImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let width: NSLayoutConstraint
        width = loginImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)
        
        let ratio: NSLayoutConstraint
        ratio = NSLayoutConstraint(item: loginImageView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: loginImageView, attribute: NSLayoutConstraint.Attribute.width, multiplier: 0.5, constant: 0.0)
        
        let bottom: NSLayoutConstraint
        bottom = NSLayoutConstraint(item: loginImageView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.inputFieldStack, attribute: NSLayoutConstraint.Attribute.top, multiplier: 0.75, constant: 0.0)
        
        centerX.isActive = true
        width.isActive = true
        ratio.isActive = true
        bottom.isActive = true
        
        self.loginImageView = loginImageView
    }
    
    func addTextField() {
        let idInputField: UITextField = UITextField()
        let pwInputField: UITextField = UITextField()
        let fieldStack: UIStackView = UIStackView()
        
        idInputField.placeholder = "ID"
        pwInputField.placeholder = "Password"
        
        idInputField.borderStyle = .roundedRect
        pwInputField.borderStyle = .roundedRect
        
        fieldStack.alignment = .fill
        fieldStack.axis = .vertical
        fieldStack.addArrangedSubview(idInputField)
        fieldStack.addArrangedSubview(pwInputField)
        fieldStack.spacing = 15.0
        
        self.view.addSubview(fieldStack)
        fieldStack.translatesAutoresizingMaskIntoConstraints = false

        let centerX: NSLayoutConstraint
        centerX = fieldStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let centerY: NSLayoutConstraint
        centerY = fieldStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        let width: NSLayoutConstraint
        width = NSLayoutConstraint(item: fieldStack, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.width, multiplier: 0.7, constant: 0.0)
        
        centerX.isActive = true
        centerY.isActive = true
        width.isActive = true
        
        self.inputFieldStack = fieldStack
        
    }

//    MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubViews()
        // Do any additional setup after loading the view.
    }


}

