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
    var signInButton: UIButton!
    var signUpButton: UIButton!
    
//    MARK: - IBOutlet
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    
//    MARK: - Subviews
    func addSubViews() {
        self.addTextFieldView()
        self.addLoginImageView()
        self.addSignButtonViews()
    }
    
    func addLoginImageView() {
        
        let loginImageView: UIImageView = UIImageView(image: UIImage(named: "loginIcon.png"))
        self.view.addSubview(loginImageView)
        loginImageView.translatesAutoresizingMaskIntoConstraints = false
        loginImageView.contentMode = .scaleAspectFit
        
        let centerX: NSLayoutConstraint
        centerX = loginImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let width: NSLayoutConstraint
        width = loginImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)
        
        let ratio: NSLayoutConstraint
        ratio = NSLayoutConstraint(item: loginImageView, attribute: .height, relatedBy: .equal, toItem: loginImageView, attribute: .width, multiplier: 0.5, constant: 0.0)
        
        let bottom: NSLayoutConstraint
        bottom = NSLayoutConstraint(item: loginImageView, attribute: .bottom, relatedBy: .equal, toItem: self.inputFieldStack, attribute: .top, multiplier: 0.75, constant: 0.0)
        
        centerX.isActive = true
        width.isActive = true
        ratio.isActive = true
        bottom.isActive = true
        
        self.loginImageView = loginImageView
    }
    
    func addTextFieldView() {
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
        width = NSLayoutConstraint(item: fieldStack, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.7, constant: 0.0)
        
        centerX.isActive = true
        centerY.isActive = true
        width.isActive = true
        
        self.inputFieldStack = fieldStack
        
    }
    
    func addSignButtonViews() {
        let signInButton: UIButton! = UIButton()
        let signUpButton: UIButton! = UIButton()
        let buttonStack: UIStackView! = UIStackView()
        
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor(.blue, for: .normal)
        signInButton.contentHorizontalAlignment = .center
        
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.red, for: .normal)
        signUpButton.contentHorizontalAlignment = .center
        
        buttonStack.axis = .horizontal
        buttonStack.alignment = .fill
        buttonStack.distribution = .fillEqually
        buttonStack.addArrangedSubview(signInButton)
        buttonStack.addArrangedSubview(signUpButton)
        
        self.view.addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX: NSLayoutConstraint
        centerX = buttonStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let top: NSLayoutConstraint
        top = buttonStack.topAnchor.constraint(equalTo: self.inputFieldStack.bottomAnchor, constant: 10)
        
        let width: NSLayoutConstraint
        width = buttonStack.widthAnchor.constraint(equalTo: self.inputFieldStack.widthAnchor)
        
        centerX.isActive = true
        top.isActive = true
        width.isActive = true
        
        self.signInButton = signInButton
        self.signUpButton = signUpButton
    }

//    MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubViews()
        // Do any additional setup after loading the view.
    }


}

