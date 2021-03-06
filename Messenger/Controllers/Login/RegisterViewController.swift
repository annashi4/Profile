//
//  RegisterViewController.swift
//  Messenger
//
//  Created by Anna on 10.06.2022.
//

import UIKit
import PhotosUI

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        
        return scrollView
    }()
    
    private var emailField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        
        field.leftView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: 5,
                                              height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        field.placeholder = "Email Adress..."
        
        return field
    }()
    
    private var firstNameField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        
        field.leftView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: 5,
                                              height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        field.placeholder = "First name"
        
        return field
    }()
    
    private var lastNameField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        
        field.leftView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: 5,
                                              height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        field.placeholder = "Last name"
        
        return field
    }()
    
    private var passwordField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        
        field.leftView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: 5,
                                              height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        
        field.placeholder = "Password"
        
        return field
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
    }()
     
        private let imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        let image = imageView.image
        imageView.tintColor = .gray
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        registerButton.addTarget(self,
                              action: #selector (didTapRegisterButton),
                              for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        //Subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(registerButton)
        
        imageView.addGestureRecognizer(gesture)
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
    }
    
    lazy var gesture = UITapGestureRecognizer(target: self,
                                              action: #selector(didTapChangeProfilePic))
    
    
    @objc func didTapChangeProfilePic(){
        
        presentPhotoActionSheet()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width - size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        imageView.layer.cornerRadius = imageView.width/2.0
        emailField.frame = CGRect(x:30,
                                  y: imageView.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 52)
        passwordField.frame = CGRect(x:30,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        firstNameField.frame = CGRect(x:30,
                                  y: passwordField.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 52)
        lastNameField.frame = CGRect(x:30,
                                  y: firstNameField.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 52)
        registerButton.frame = CGRect(x:30,
                                   y: lastNameField.bottom + 10,
                                   width: scrollView.width - 60,
                                   height: 52)
        
        
    }
    
    @objc private func didTapRegisterButton(){
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text,
              let password = passwordField.text,
              let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              !email.isEmpty,
              !password.isEmpty,
              !firstName.isEmpty,
              !lastName.isEmpty,
              password.count >= 6 else {
            return alertUserLoginError()
        }
        
    }
    
    func alertUserLoginError(){
        let alert = UIAlertController(title: "Woops", message: "Please enter all information to create an account. Mind that your password needs to be longer than 6 charachters!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present (alert, animated: true)
    }
    
    @objc private func didTapRegister() {
        
        let registerVC = RegisterViewController()
        registerVC.title = "Create Account"
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
}

extension RegisterViewController {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            
            didTapRegisterButton()
        }
        
        return true
    }
    
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile picture",
                                            message: "How would you like to select a pictre?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take photo",
                                            style: .default,
                                            handler: { [weak self] _ in self?.presentCamera()
    
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose photo",
                                            style: .default,
                                            handler: { [weak self] _ in self?.presentPhotoPicker()
        }))
        
        present(actionSheet, animated: true)
    }
    

    func presentCamera() {
        let vc = UIImagePickerController()
        
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present (vc, animated: true)
    }

    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present (vc, animated: true)


    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        self.imageView.image = selectedImage
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

