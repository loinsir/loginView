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
        let detailViewController: UIViewController = DetailSignUpViewController()
        self.show(detailViewController, sender: self)
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
        let userImgView: UIImageView = UIImageView()
        let idFieldView: UITextField = UITextField()
        let pwFieldView: UITextField = UITextField()
        let validPWFieldView: UITextField = UITextField()
        
        pwFieldView.isSecureTextEntry = true
        validPWFieldView.isSecureTextEntry = true
        
        idFieldView.placeholder = "ID"
        pwFieldView.placeholder = "Password"
        validPWFieldView.placeholder = "Check Password"
        
        idFieldView.borderStyle = .roundedRect
        pwFieldView.borderStyle = .roundedRect
        validPWFieldView.borderStyle = .roundedRect
        
        userImgView.backgroundColor = .systemOrange
        userImgView.tintColor = .systemYellow
        userImgView.adjustsImageSizeForAccessibilityContentSizeCategory = false
        
        // vertical stack of textfields
        let textFieldStack: UIStackView = UIStackView(arrangedSubviews: [idFieldView, pwFieldView, validPWFieldView])
        textFieldStack.axis = .vertical
        textFieldStack.spacing = 10
        textFieldStack.alignment = .fill
        textFieldStack.distribution = .fillEqually
        
        // horizontal stack of textfields and imagefield
        let fieldstack: UIStackView = UIStackView(arrangedSubviews: [userImgView, textFieldStack])
        fieldstack.axis = .horizontal
        fieldstack.spacing = 10
        
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
        
        idFieldView.addTarget(self, action: #selector(confirmButtonState(_:)), for: .editingChanged)
        pwFieldView.addTarget(self, action: #selector(confirmButtonState(_:)), for: .editingChanged)
        validPWFieldView.addTarget(self, action: #selector(confirmButtonState(_:)), for: .editingChanged)
        
        let touchUserImageField: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchUserImageField(_:)))
        userImgView.addGestureRecognizer(touchUserImageField)
        userImgView.isUserInteractionEnabled = true

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
        let cancel = UIButton()
        let confirm = UIButton()
        
        cancel.setTitle("Cancel", for: .normal)
        cancel.setTitleColor(.systemRed, for: .normal)
        cancel.setTitleColor(.opaqueSeparator, for: .highlighted)
        cancel.addTarget(self, action: #selector(touchCancelButton(_:)), for: .touchUpInside)
        
        confirm.setTitle("Confirm", for: .normal)
        confirm.setTitleColor(.systemBlue, for: .normal)
        confirm.setTitleColor(.opaqueSeparator, for: .highlighted)
        confirm.setTitleColor(.opaqueSeparator, for: .disabled)
        
        let buttonStack: UIStackView = UIStackView(arrangedSubviews: [cancel, confirm])
        buttonStack.axis = .horizontal
        buttonStack.alignment = .fill
        buttonStack.distribution = .fillEqually
        
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
        
        confirm.isEnabled = false // default state of button
        confirm.addTarget(self, action: #selector(touchConfirmButton(_:)), for: .touchUpInside)
        
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
