//
//  ViewController.swift
//  SignUpWork
//
//
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
//    MARK: - Properties
    var loginImageView: UIImageView!
    var inputFieldStack: UIStackView!
    var signInButton: UIButton!
    var signUpButton: UIButton!
    
//    MARK: - IBOutlet
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    
//    MARK: - IBAction
    @IBAction func touchSignInButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchSignUpButton(_ sender: UIButton) {
        let signUpViewController = SignUpViewController()
    
        let navigationController = UINavigationController(rootViewController: signUpViewController)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.isNavigationBarHidden = true
        self.present(navigationController, animated: true, completion: nil)
    }
    
//    MARK: - Subviews
    func addSubViews() {
        self.addTextFieldView()
        self.addLoginImageView()
        self.addSignButtonViews()
        self.addGestureRecognizer()
    }
    
    func addTextFieldView() {
        let idInputField: UITextField = UITextField()
        let pwInputField: UITextField = UITextField()
        let fieldStack: UIStackView = UIStackView()
        
        idInputField.placeholder = "ID"
        pwInputField.placeholder = "Password"
        
        idInputField.borderStyle = .roundedRect
        pwInputField.borderStyle = .roundedRect
        
        pwInputField.isSecureTextEntry = true
        
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

    
    func addLoginImageView() {
        
        let loginImageView: UIImageView = UIImageView(image: UIImage(named: "loginIcon.png"))
        
        self.view.addSubview(loginImageView)
        loginImageView.translatesAutoresizingMaskIntoConstraints = false
        loginImageView.contentMode = .scaleAspectFit
        
        let centerX: NSLayoutConstraint
        centerX = loginImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let bottom: NSLayoutConstraint
        bottom = NSLayoutConstraint(item: loginImageView, attribute: .bottom, relatedBy: .equal, toItem: self.inputFieldStack, attribute: .top, multiplier: 1.0, constant: 0.0)
        
        let top: NSLayoutConstraint
        top = NSLayoutConstraint(item: loginImageView, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0.0)
        
        let ratio: NSLayoutConstraint
        ratio = NSLayoutConstraint(item: loginImageView, attribute: .width, relatedBy: .equal, toItem: loginImageView, attribute: .height, multiplier: 0.65, constant: 0.0)
        
        centerX.isActive = true
        bottom.isActive = true
        top.isActive = true
        ratio.isActive = true
        
        self.loginImageView = loginImageView
    }
    
    func addSignButtonViews() {
        let signInButton: UIButton! = UIButton()
        let signUpButton: UIButton! = UIButton()
        let buttonStack: UIStackView! = UIStackView()
        
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor(.systemBlue, for: .normal)
        signInButton.setTitleColor(.opaqueSeparator, for: .highlighted)
        signInButton.contentHorizontalAlignment = .center
        
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.red, for: .normal)
        signUpButton.setTitleColor(.opaqueSeparator, for: .highlighted)
        signUpButton.contentHorizontalAlignment = .center
        
        buttonStack.axis = .horizontal
        buttonStack.alignment = .fill
        buttonStack.distribution = .fillEqually
        buttonStack.addArrangedSubview(signInButton)
        buttonStack.addArrangedSubview(signUpButton)
        
        signInButton.addTarget(self, action: #selector(touchSignInButton(_:)), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(touchSignUpButton(_:)), for: .touchUpInside)
        
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
    
//    MARK: GestureRecognizer
    func addGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.delegate = self
        
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }

//    MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubViews()
        // Do any additional setup after loading the view.
    }

}
