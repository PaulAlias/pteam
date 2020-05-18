//
//  LoginViewController.swift
//  Networking
//
//  Created by Павел Алешин on 18.05.2020.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {
    var userProfile: UserProfile?
    
    lazy var fbLoginButton: UIButton = {
        
        let loginButton = FBLoginButton()
        loginButton.frame = CGRect(x: 32, y: 380, width: view.frame.width - 64, height: 50)
        //loginButton.delegate = self
        //loginButton.center = view.center
        return loginButton
    }()
    
    lazy var customFBLoginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.backgroundColor = UIColor(hexValue: "#3B5999", alpha: 1)
        loginButton.setTitle("Вход через FaceBook", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.frame = CGRect(x: 32, y: 380 + 80, width: view.frame.width - 64, height: 50)
        loginButton.layer.cornerRadius = 4
        
        loginButton.addTarget(self, action: #selector(handleCustomFaceBookLogin), for: .touchUpInside)
        return loginButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        //         проверка авторизации пользователя
        //         if let token = AccessToken.current, !token.isExpired {
        //            print("The user is logged in")
        //        }
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(fbLoginButton)
        view.addSubview(customFBLoginButton)
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

//MARK: FaceBook SDK

extension LoginViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error != nil {
            print(error)
            return
            
        }
        guard AccessToken.isCurrentAccessTokenActive else { return }
        signIntoFirebase()
        print("Succefully logged in with FaceBook ...")
        
    }
    
    
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Did log out of FaceBook ...")
    }
    
    private func openMainViewController() {
        dismiss(animated: true)
    }
    
    @objc private func handleCustomFaceBookLogin() {
        
        LoginManager().logIn(permissions: ["email", "public_profile"], from: self) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
             guard let result = result else { return }
            
            if result.isCancelled { return }
            else {
                
                self.signIntoFirebase()
               
            }
        }
        
        
    }
    
    private func signIntoFirebase() {
        
        let accessToken = AccessToken.current
        
        guard let accesTokenString = accessToken?.tokenString  else { return }
        
        let credentails = FacebookAuthProvider.credential(withAccessToken: accesTokenString)
        
        Auth.auth().signIn(with: credentails) { (user, error) in
            if let error = error {
                print("Что-то пошло не так с регистрацией FaceBook: ", error.localizedDescription)
                return
            }
            
            print("Successfuly logged in with our FB user: ")
            self.fetchFaceBookFields()
            
        }
        
    }
    
    private func fetchFaceBookFields() {
        
        GraphRequest(graphPath: "me", parameters: ["fields":"id, name, email"]).start { (_, result, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let userData = result as? [String: Any] {
                self.userProfile = UserProfile(data: userData)
                print(self.userProfile?.name ?? nil)
                self.saveIntoFirebase()
            }
        }
    }
    
    private func saveIntoFirebase() {
        
       guard let uid = Auth.auth().currentUser?.uid  else { return }
        
        let userData = ["name" : userProfile?.name, "email" : userProfile?.email]
        
        let values = [uid : userData]
        
        Database.database().reference().child("users").updateChildValues(values) { (error, _) in
            if let error = error {
                print(error)
                return
            }
            
            print("Successfuly save user into firebase database")
            self.openMainViewController()
        }
    }
}
