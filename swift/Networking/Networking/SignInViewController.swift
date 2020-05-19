//
//  SignInViewController.swift
//  Networking
//
//  Created by Павел Алешин on 19.05.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(secondaryColor, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = CGPoint(x: view.center.x, y: view.frame.height - 100)
        button.layer.cornerRadius = 4
        button.alpha = 0.5
        
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        view.addSubview(continueButton)
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc private func handleSignIn() {
        
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
