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
    
//    MARK: - IBOutlet
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    
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
        let idInputField: UITextField = {
            let field: UITextField = UITextField()
            field.placeholder = "ID"
            field.borderStyle = .roundedRect
            return field
        }()
        
        let pwInputField: UITextField = {
            let field: UITextField = UITextField()
            field.placeholder = "Password"
            field.borderStyle = .roundedRect
            field.isSecureTextEntry = true
            return field
        }()
        
        let fieldStack: UIStackView = {
            let stackView: UIStackView = UIStackView()
            stackView.alignment = .fill
            stackView.axis = .vertical
            stackView.addArrangedSubview(idInputField)
            stackView.addArrangedSubview(pwInputField)
            stackView.spacing = 15.0
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        if let signUpId = UserInformation.shared.id {
            idInputField.text = signUpId
        }
        if let signUpPW = UserInformation.shared.password {
            pwInputField.text = signUpPW
        }
    
        self.view.addSubview(fieldStack)
        
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
        let loginImageView: UIImageView = {
            let imageView: UIImageView = UIImageView()
            imageView.image = UIImage(named: "loginIcon.png")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        self.view.addSubview(loginImageView)
        
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
        let signInButton: UIButton = {
            let button: UIButton = UIButton()
            button.setTitle("Sign In", for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            button.setTitleColor(.opaqueSeparator, for: .highlighted)
            button.contentHorizontalAlignment = .center
            return button
        }()
        signInButton.addTarget(self, action: #selector(touchSignInButton(_:)), for: .touchUpInside)
        
        let signUpButton: UIButton = {
            let button: UIButton = UIButton()
            button.setTitle("Sign Up", for: .normal)
            button.setTitleColor(.red, for: .normal)
            button.setTitleColor(.opaqueSeparator, for: .highlighted)
            button.contentHorizontalAlignment = .center
            return button
        }()
        signUpButton.addTarget(self, action: #selector(touchSignUpButton(_:)), for: .touchUpInside)
        
        let buttonStack: UIStackView = {
            let stackView: UIStackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.addArrangedSubview(signInButton)
            stackView.addArrangedSubview(signUpButton)
            return stackView
        }()
        
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
