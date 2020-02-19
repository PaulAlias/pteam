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
    
    var present = ""
    var emoji = ""
    var currentPage = 0 //number current page
    var numberOfPages = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presentText.text = present
        emojiText.text = emoji
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = numberOfPages
        
    }
    


}
