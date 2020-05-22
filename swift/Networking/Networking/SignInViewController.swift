//
//  SignInViewController.swift
//  Networking
//
//  Created by Павел Алешин on 19.05.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView!
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(secondaryColor, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        //задает центрирование относительно какого либо объектра (в давнном случае экрана)
        button.center = CGPoint(x: view.center.x, y: view.frame.height - 100)
        button.layer.cornerRadius = 4
        button.alpha = 0.5
        
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return button
    }()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        view.addSubview(continueButton)
        setContinueButton(enabled: false)
        
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = secondaryColor
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.center = continueButton.center
        
        view.addSubview(activityIndicator)
        
        emailTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTextFiled.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc private func keyboardWillAppear(notification: NSNotification) {
        
        //получаем данные словаря и габаритов клавиатуры
        let userInfo = notification.userInfo
        let keyboardFrame = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        continueButton.center = CGPoint(x: view.center.x, y: view.frame.height - keyboardFrame.height - 16.0 - continueButton.frame.height / 2 )
        activityIndicator.center = continueButton.center
        
    }
    
    
    @objc private func handleSignIn() {
        
        setContinueButton(enabled: false)
        continueButton.setTitle("", for: .normal)
        activityIndicator.startAnimating()
        
        guard let email = emailTextField.text, let password = passwordTextFiled.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                
                self.setContinueButton(enabled: true)
                self.continueButton.setTitle("Войти", for: .normal)
                self.activityIndicator.stopAnimating()
                
                return
            }
            
            print("Succesfully loggen in with Email")
            //нужно закрыть открытые до этого вьюконтроллеры
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            
        }
    }
    
    @objc private func textFieldChanged() {
        
        guard let email = emailTextField.text, let password = passwordTextFiled.text else { return }
        
        let formFiled = !(email.isEmpty)  && !(password.isEmpty)
        
        setContinueButton(enabled: formFiled)
        
    }
    
    private func setContinueButton(enabled: Bool) {
        
        if enabled {
            continueButton.alpha = 1.0
            continueButton.isEnabled = true
        } else {
            continueButton.alpha = 0.5
            continueButton.isEnabled = false
        }
    }
    
    
    
}
