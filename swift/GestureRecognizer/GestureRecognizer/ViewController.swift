//
//  ViewController.swift
//  GestureRecognizer
//
//  Created by Павел Алешин on 21/02/2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recognizerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeObservers()
        tapObservers()
    }
    
    func swipeObservers() {
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(hanldeSwipes))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(hanldeSwipes))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(hanldeSwipes))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(hanldeSwipes))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    
    func tapObservers() {
        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(tripleTapAction))
        tripleTap.numberOfTapsRequired = 3
        self.view.addGestureRecognizer(tripleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapAction))
        doubleTap.require(toFail: tripleTap)
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
    }
    
        
    @objc func hanldeSwipes(gester: UISwipeGestureRecognizer) {
        
        switch gester.direction {
            case .right:
                recognizerLabel.text = "right"
            case .left:
                recognizerLabel.text = "left"
            case .up:
                recognizerLabel.text = "up"
            case .down:
                recognizerLabel.text = "down"
        default:
            break
        }
        
    }
    
    @objc func tripleTapAction(gester: UITapGestureRecognizer) {
        recognizerLabel.text = "tripleTap"
    }
    
    @objc func doubleTapAction(gester: UITapGestureRecognizer) {
        recognizerLabel.text = "doubleTap"
    }

}

