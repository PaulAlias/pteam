//
//  ContentViewController.swift
//  PageViewController
//
//  Created by Павел Алешин on 19/02/2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var presentText: UILabel!
    @IBOutlet weak var emojiText: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var closeButn: UIButton!
    
    
    var present = ""
    var emoji = ""
    var currentPage = 0 //number current page
    var numberOfPages = 0
    var hideButon = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presentText.text = present
        emojiText.text = emoji
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = currentPage
        closeButn.isHidden = hideButon

       
        
    }
    

    @IBAction func cliclButnClose(_ sender: UIButton) {
                      
        dismiss(animated: true, completion: nil)
    }
    
}
