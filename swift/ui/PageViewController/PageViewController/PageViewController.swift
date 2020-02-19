//
//  PageViewController.swift
//  PageViewController
//
//  Created by Павел Алешин on 19/02/2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    let presetContentArray = [
    "Начало страница презентации",
    "Середина страница перезентации",
    "Конец страница перезентации"
    ]
    
    let emojiArray = [
    "🥰",
    "✌️",
    "😻"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        if let contentViewController = showViewControllerAtIndex(0) {
        setViewControllers([contentViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func showViewControllerAtIndex(_ index: Int) -> ContentViewController?{
        
        guard index >= 0 else {return nil}
        guard index < presetContentArray.count else {return nil}
        guard let contentViewController = storyboard?.instantiateViewController(
            withIdentifier: "ContentViewController") as? ContentViewController else { return nil }
        
        contentViewController.present = presetContentArray[index]
        contentViewController.emoji = emojiArray[index]
        contentViewController.currentPage = index
        contentViewController.numberOfPages = presetContentArray.count
        
        return contentViewController
    }


}
