//
//  SignUpViewController.swift
//  SignUpWork
//
//  Created by 김인환 on 2021/07/30.
//

import UIKit

class SignUpViewController: UIViewController, UINavigationControllerDelegate {
    
//    MARK: - Properties
    lazy var userImagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        return picker
    }()
    
//    MARK: - IBOutlet
    @IBOutlet var userImageField: UIImageView!
    
    @IBOutlet var idField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var checkPasswordField: UITextField!
    @IBOutlet var userDescriptionField: UITextView!
    
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var confirmButton: UIButton!
    
//    MARK: - Action
    @objc func touchCancelButton(_ sender: UIButton) {
        UserInformation.shared.clearFields()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func touchUserImageField(_ sender: UIImageView) {
        self.present(self.userImagePicker, animated: true, completion: nil)
    }
    
    //  Confirm button state check
    @objc func confirmButtonState(_ sender: UIView) {
        if self.userImageField.image != nil
            && self.idField.text != ""
            && self.passwordField.text != ""
            && self.checkPasswordField.text != ""
            && self.userDescriptionField.text != ""
            && self.passwordField.text == self.checkPasswordField.text{
                self.confirmButton.isEnabled = true
        } else {
            self.confirmButton.isEnabled = false
        }
    }
    
    @objc func touchConfirmButton(_ sender: UIButton) {
        UserInformation.shared.image = self.userImageField.image
        UserInformation.shared.id = self.idField.text
        UserInformation.shared.password = self.passwordField.text
        UserInformation.shared.description = self.userDescriptionField.text
        
        let detailViewController: UIViewController = DetailSignUpViewController()
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
//    MARK: - SubView
    func addSubViews() {
        self.addGestureRecognizer()
        self.addUserImageAndFieldView()
        self.addUserDescriptionField()
        self.addCancelAndConfirmButton()
    }
    
    func addUserImageAndFieldView() {
        let userImageView: UIImageView = {
            let imgView: UIImageView = UIImageView()
            imgView.backgroundColor = .systemOrange
            imgView.tintColor = .systemYellow
            imgView.adjustsImageSizeForAccessibilityContentSizeCategory = false
            return imgView
        }()
        let touchUserImageField: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchUserImageField(_:)))
        userImageView.addGestureRecognizer(touchUserImageField)
        userImageView.isUserInteractionEnabled = true
        
        
        let idFieldView: UITextField = {
            let field: UITextField = UITextField()
            field.placeholder = "ID"
            field.borderStyle = .roundedRect
            return field
        }()
        idFieldView.addTarget(self, action: #selector(confirmButtonState(_:)), for: .editingChanged)
        
        let passwordFieldView: UITextField = {
            let field: UITextField = UITextField()
            field.placeholder = "Password"
            field.isSecureTextEntry = true
            field.borderStyle = .roundedRect
            return field
        }()
        passwordFieldView.addTarget(self, action: #selector(confirmButtonState(_:)), for: .editingChanged)
        
        let validPasswordFieldView: UITextField = {
            let field: UITextField = UITextField()
            field.placeholder = "Check Password"
            field.isSecureTextEntry = true
            field.borderStyle = .roundedRect
            return field
        }()
        validPasswordFieldView.addTarget(self, action: #selector(confirmButtonState(_:)), for: .editingChanged)
        
        // vertical stack of textfields
        let textFieldStack: UIStackView = {
            let stack: UIStackView = UIStackView(arrangedSubviews: [idFieldView, passwordFieldView, validPasswordFieldView])
            stack.axis = .vertical
            stack.spacing = 10
            stack.alignment = .fill
            stack.distribution = .fillEqually
            return stack
        }()
        
        // horizontal stack of textfields and imagefield
        let fieldstack: UIStackView = {
            let stack: UIStackView = UIStackView(arrangedSubviews: [userImageView, textFieldStack])
            stack.axis = .horizontal
            stack.spacing = 10
            return stack
        }()
        
        self.view.addSubview(fieldstack)
        fieldstack.translatesAutoresizingMaskIntoConstraints = false
        
        let top: NSLayoutConstraint
        top = fieldstack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10.0)
        
        let centerX: NSLayoutConstraint
        centerX = fieldstack.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        
        let width: NSLayoutConstraint
        width = fieldstack.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9)
        
        let imageFieldRatio: NSLayoutConstraint
        imageFieldRatio = NSLayoutConstraint(item: userImageView, attribute: .height, relatedBy: .equal, toItem: userImageView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        let height: NSLayoutConstraint
        height = fieldstack.heightAnchor.constraint(equalTo: userImageView.heightAnchor)
        
        let textFieldStackWidth: NSLayoutConstraint
        textFieldStackWidth = textFieldStack.widthAnchor.constraint(equalTo: fieldstack.widthAnchor, multiplier: 0.66)
        
        top.isActive = true
        centerX.isActive = true
        width.isActive = true
        imageFieldRatio.isActive = true
        height.isActive = true
        textFieldStackWidth.isActive = true

        self.userImageField = userImageView
        self.idField = idFieldView
        self.passwordField = passwordFieldView
        self.checkPasswordField = validPasswordFieldView
    }
    
    func addUserDescriptionField() {
        let descriptionField: UITextView = UITextView()
        descriptionField.layer.borderWidth = 1.0
        descriptionField.layer.borderColor = UIColor.gray.cgColor
        
        self.view.addSubview(descriptionField)
        descriptionField.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX: NSLayoutConstraint
        centerX = descriptionField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let top: NSLayoutConstraint
        top = descriptionField.topAnchor.constraint(equalTo: self.checkPasswordField.bottomAnchor, constant: 10.0)
        
        let width: NSLayoutConstraint
        width = descriptionField.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9)
        
        let bottom: NSLayoutConstraint
        bottom = descriptionField.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -100.0)
        
        centerX.isActive = true
        top.isActive = true
        bottom.isActive = true
        width.isActive = true
        
        self.userDescriptionField = descriptionField
    }
    
    func addCancelAndConfirmButton() {
        let cancel: UIButton = {
            let button: UIButton = UIButton()
            button.setTitle("Cancel", for: .normal)
            button.setTitleColor(.systemRed, for: .normal)
            button.setTitleColor(.opaqueSeparator, for: .highlighted)
            return button
        }()
        cancel.addTarget(self, action: #selector(touchCancelButton(_:)), for: .touchUpInside)
        
        let confirm: UIButton = {
            let button: UIButton = UIButton()
            button.setTitle("Confirm", for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            button.setTitleColor(.opaqueSeparator, for: .highlighted)
            button.setTitleColor(.opaqueSeparator, for: .disabled)
            button.isEnabled = false // default state of button
            return button
        }()
        confirm.addTarget(self, action: #selector(touchConfirmButton(_:)), for: .touchUpInside)
        
        let buttonStack: UIStackView = {
            let stack: UIStackView = UIStackView(arrangedSubviews: [cancel, confirm])
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .fillEqually
            return stack
        }()
        self.view.addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX: NSLayoutConstraint
        centerX = buttonStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let bottom: NSLayoutConstraint
        bottom = buttonStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        let width: NSLayoutConstraint
        width = buttonStack.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor)
        
        let top: NSLayoutConstraint
        top = buttonStack.topAnchor.constraint(equalTo: self.userDescriptionField.bottomAnchor, constant: 10)
        
        centerX.isActive = true
        bottom.isActive = true
        width.isActive = true
        top.isActive = true
        
        self.cancelButton = cancel
        self.confirmButton = confirm
        
    }
    
    func addGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.delegate = self
        self.view.addGestureRecognizer(gestureRecognizer)
    }

//    MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
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

//    MARK: - UIImagePickerControllerDelegate
extension SignUpViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage: UIImage = info[.editedImage] as? UIImage {
            self.userImageField.image = selectedImage
            self.confirmButtonState(self.userImageField)
            self.dismiss(animated: true, completion: nil)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

//    MARK: - GestureRecognizer
extension SignUpViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
    }
}

//  MARK: - UITextViewDelegate
extension SignUpViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        self.confirmButtonState(textView)
    }
}
