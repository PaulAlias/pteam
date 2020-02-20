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
    "Конец страница перезентации",
    "Спасибо за внимание."
    ]
    
    let emojiArray = [
    "🥰",
    "✌️",
    "😻",
    "🤚"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let contentViewController = showViewControllerAtIndex(0) {
        setViewControllers([contentViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func showViewControllerAtIndex(_ index: Int) -> ContentViewController?{
        
        guard index >= 0 else {return nil}
        guard index < presetContentArray.count else {
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "presentationWasViewed")
        //dismiss(animated: true, completion: nil)
            return nil
        }
        guard let contentViewController = storyboard?.instantiateViewController(
            withIdentifier: "ContentViewController") as? ContentViewController else { return nil }
        
        contentViewController.present = presetContentArray[index]
        contentViewController.emoji = emojiArray[index]
        contentViewController.currentPage = index
        contentViewController.numberOfPages = presetContentArray.count
        
        if contentViewController.currentPage > presetContentArray.count - 2 {
            contentViewController.hideButon = false
        } else {
            contentViewController.hideButon = true
        }
        
        return contentViewController
    }


}


extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
       var numberPage = (viewController as! ContentViewController).currentPage
        numberPage -= 1
        
       return showViewControllerAtIndex(numberPage)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var numberPage = (viewController as! ContentViewController).currentPage
         numberPage += 1
         
       return showViewControllerAtIndex(numberPage)
    }
    	
}
