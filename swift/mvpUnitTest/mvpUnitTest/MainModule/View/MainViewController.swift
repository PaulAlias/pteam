//
//  ViewController.swift
//  mvpUnitTest
//
//  Created by Павел Алешин on 19.03.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var greetingLabel: UILabel!
    
    var presenter: MainViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK: - IBAction
    @IBAction func didTapButtonAction(_ sender: Any){
        self.presenter.showGreeting()
    }

}


extension MainViewController: MainViewProtocol {
    func setGreeting(greeting: String) {
        self.greetingLabel.text = greeting
    }
}
