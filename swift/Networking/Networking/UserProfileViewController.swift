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

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var activityIndicatior: UIActivityIndicatorView!
    
    lazy var fbLoginButton: UIButton = {
        
         let loginButton = FBLoginButton()
        loginButton.frame = CGRect(x: 32, y: view.frame.height - 172, width: view.frame.width - 64, height: 50)
         loginButton.delegate = self
         //loginButton.center = view.center
         return loginButton
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
        view.addSubview(fbLoginButton)
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

extension UserProfileViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error != nil {
            print(error)
            return
            
        }
        
        print("Succefully logged in with FaceBook ...")

    }
    
    
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
        openLoginViewController()
         print("Did log out of FaceBook ...")
    }
    
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
        
        if Auth.auth().currentUser != nil {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard let userData = snapshot.value as? [String : Any] else { return }
                
                self.activityIndicatior.stopAnimating()
                self.userNameLabel.isHidden = false

                let currentUser = CurrentUser(uid: uid, data: userData)
                

                
                self.userNameLabel.text = "\(currentUser?.name ?? "Noname") Logged in with FaceBook"
                
                
            }) { (error) in
                print(error)
            }
        }
    }
    
    
}
