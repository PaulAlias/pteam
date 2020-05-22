//
//  UserProfileViewController.swift
//  Networking
//
//  Created by Павел Алешин on 18.05.2020.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import FirebaseDatabase
import GoogleSignIn

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var activityIndicatior: UIActivityIndicatorView!
    
    private var provider: String?
    private var currentUser: CurrentUser?
    
    
    lazy var logoutButton: UIButton = {
        
        let button = UIButton()
        button.frame = CGRect(x: 32, y: view.frame.height - 172, width: view.frame.width - 64, height: 50)
        //loginButton.delegate = self
        //loginButton.center = view.center
        button.backgroundColor = UIColor(hexValue: "#3B5999", alpha: 1)
        button.setTitle("Log Out", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        userNameLabel.isHidden = true
        setupeView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchingUserData()
    }
    
    
    private func setupeView() {
        view.addSubview(logoutButton)
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


extension UserProfileViewController {
    
    private func openLoginViewController() {
        
        do {
            try Auth.auth().signOut()
            
            DispatchQueue.main.async {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.present(loginViewController, animated: true)
                return
            }
            
        } catch let error {
            print("Faild to sign Out with error: ", error.localizedDescription)
        }
        
    }
    
    private func fetchingUserData() {
        
        if let userName = Auth.auth().currentUser?.displayName {
            activityIndicatior.stopAnimating()
            userNameLabel.isHidden = false
            userNameLabel.text = getProviderData(with: userName)
        } else {
            
            if Auth.auth().currentUser != nil {
                guard let uid = Auth.auth().currentUser?.uid else { return }
                
                Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    guard let userData = snapshot.value as? [String : Any] else { return }
                    
                    self.activityIndicatior.stopAnimating()
                    self.userNameLabel.isHidden = false
                    
                    self.currentUser = CurrentUser(uid: uid, data: userData)
                    
                    
                    
                    self.userNameLabel.text = self.getProviderData(with: self.currentUser?.name ?? "Noname")
                    
                    
                }) { (error) in
                    print(error)
                }
            }
        }
    }
    
    @objc private func signOut() {
        
        if let providerData = Auth.auth().currentUser?.providerData {
            
            for userInfo in providerData {
                
                switch userInfo.providerID {
                case "facebook.com":
                    LoginManager().logOut()
                    print("User did log out of Facebook")
                    openLoginViewController()
                case "google.com":
                    GIDSignIn.sharedInstance()?.signOut()
                    print("User did log out of Google")
                    openLoginViewController()
                case "password":
                    try! Auth.auth().signOut()
                    print("User did log out of Email")
                    openLoginViewController()
                default:
                    print("User is signed in with \(userInfo.providerID)")
                }
            }
        }
        
    }
    
    private func getProviderData(with user: String) -> String {
        var greetings = ""
        
        if let providerData = Auth.auth().currentUser?.providerData {
            for userInfo in providerData {
                switch userInfo.providerID {
                case "facebook.com":
                    provider = "Facebook"
                case "google.com":
                    provider = "Google"
                case "password":
                    provider = "Email"
                default:
                    break
                }
            }
            
            greetings = "\(user) logged in with \(provider!)"
        }
        
        return greetings
    }
}
