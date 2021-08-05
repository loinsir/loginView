//
//  SignUpViewController.swift
//  SignUpWork
//
//  Created by 김인환 on 2021/07/30.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
//    MARK: - Properties
    lazy var userImgPicker: UIImagePickerController = {
        let imgPicker: UIImagePickerController = UIImagePickerController()
        imgPicker.sourceType = .photoLibrary
        imgPicker.delegate = self
        imgPicker.allowsEditing = true
        return imgPicker
    }()
    
//    MARK: - IBOutlet
    @IBOutlet var userImageField: UIImageView!
    
    @IBOutlet var idField: UITextField!
    @IBOutlet var pwField: UITextField!
    @IBOutlet var chckPwField: UITextField!
    @IBOutlet var userDescField: UITextField!
    
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var confirmButton: UIButton!
    
//    MARK: - IBAction
    @IBAction func touchCancelButton(_ sender: UIButton) {
        UserInformation.shared.clearFields()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUserImageField(_ sender: UIImageView) {
        self.present(self.userImgPicker, animated: true, completion: nil)
    }
    
    //  Confirm button state check
    @IBAction func confirmButtonState(_ sender: UIView) {
        if self.userImageField.image != nil
            && self.idField.text != ""
            && self.pwField.text != ""
            && self.chckPwField.text != ""
            && self.userDescField.text != "" {
            if self.pwField.text == self.chckPwField.text {
                self.confirmButton.isEnabled = true
            } else {
                self.confirmButton.isEnabled = false
            }
        } else {
            self.confirmButton.isEnabled = false
        }
    }
    
    @IBAction func touchConfirmButton(_ sender: UIButton) {
        UserInformation.shared.image = self.userImageField.image
        UserInformation.shared.id = self.idField.text
        UserInformation.shared.password = self.pwField.text
        UserInformation.shared.description = self.userDescField.text
        
        let detailViewController: UIViewController = DetailSignUpViewController()
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
//    MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImg: UIImage = info[.editedImage] as? UIImage {
            self.userImageField.image = selectedImg
            self.confirmButtonState(self.userImageField)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
//    MARK: - SubView
    func addSubViews() {
        self.addGestureRecognizer()
        self.addUserImgAndFieldView()
        self.addUserDescriptionField()
        self.addCancelAndConfirmButton()
    }
    
    func addUserImgAndFieldView() {
        let userImgView: UIImageView = {
            let imgView: UIImageView = UIImageView()
            imgView.backgroundColor = .systemOrange
            imgView.tintColor = .systemYellow
            imgView.adjustsImageSizeForAccessibilityContentSizeCategory = false
            return imgView
        }()
        let touchUserImageField: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchUserImageField(_:)))
        userImgView.addGestureRecognizer(touchUserImageField)
        userImgView.isUserInteractionEnabled = true
        
        
        let idFieldView: UITextField = {
            let field: UITextField = UITextField()
            field.placeholder = "ID"
            field.borderStyle = .roundedRect
            return field
        }()
        idFieldView.addTarget(self, action: #selector(confirmButtonState(_:)), for: .editingChanged)
        
        let pwFieldView: UITextField = {
            let field: UITextField = UITextField()
            field.placeholder = "Password"
            field.isSecureTextEntry = true
            field.borderStyle = .roundedRect
            return field
        }()
        pwFieldView.addTarget(self, action: #selector(confirmButtonState(_:)), for: .editingChanged)
        
        let validPWFieldView: UITextField = {
            let field: UITextField = UITextField()
            field.placeholder = "Check Password"
            field.isSecureTextEntry = true
            field.borderStyle = .roundedRect
            return field
        }()
        validPWFieldView.addTarget(self, action: #selector(confirmButtonState(_:)), for: .editingChanged)
        
        // vertical stack of textfields
        let textFieldStack: UIStackView = {
            let stack: UIStackView = UIStackView(arrangedSubviews: [idFieldView, pwFieldView, validPWFieldView])
            stack.axis = .vertical
            stack.spacing = 10
            stack.alignment = .fill
            stack.distribution = .fillEqually
            return stack
        }()
        
        // horizontal stack of textfields and imagefield
        let fieldstack: UIStackView = {
            let stack: UIStackView = UIStackView(arrangedSubviews: [userImgView, textFieldStack])
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
        
        let imgFieldRatio: NSLayoutConstraint
        imgFieldRatio = NSLayoutConstraint(item: userImgView, attribute: .height, relatedBy: .equal, toItem: userImgView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        let height: NSLayoutConstraint
        height = fieldstack.heightAnchor.constraint(equalTo: userImgView.heightAnchor)
        
        let textFieldStackWidth: NSLayoutConstraint
        textFieldStackWidth = textFieldStack.widthAnchor.constraint(equalTo: fieldstack.widthAnchor, multiplier: 0.66)
        
        top.isActive = true
        centerX.isActive = true
        width.isActive = true
        imgFieldRatio.isActive = true
        height.isActive = true
        textFieldStackWidth.isActive = true

        self.userImageField = userImgView
        self.idField = idFieldView
        self.pwField = pwFieldView
        self.chckPwField = validPWFieldView
    }
    
    func addUserDescriptionField() {
        let descField: UITextField = UITextField()
        descField.borderStyle = .bezel
        
        self.view.addSubview(descField)
        descField.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX: NSLayoutConstraint
        centerX = descField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let top: NSLayoutConstraint
        top = descField.topAnchor.constraint(equalTo: self.chckPwField.bottomAnchor, constant: 10.0)
        
        let width: NSLayoutConstraint
        width = descField.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9)
        
        let bottom: NSLayoutConstraint
        bottom = descField.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -100.0)
        
        centerX.isActive = true
        top.isActive = true
        bottom.isActive = true
        width.isActive = true
        
        descField.addTarget(self, action: #selector(confirmButtonState(_:)), for: .editingChanged)
        self.userDescField = descField
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
        top = buttonStack.topAnchor.constraint(equalTo: self.userDescField.bottomAnchor, constant: 10)
        
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
    
//    MARK: GestureRecognizer
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
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
