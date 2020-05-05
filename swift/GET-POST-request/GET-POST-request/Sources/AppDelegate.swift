//
//  AppDelegate.swift
//  GET-POST-request
//
//  Created by Павел Алешин on 24.04.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var bgSessionCompletionHandler: (() -> ())?
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        
        bgSessionCompletionHandler = completionHandler
        
    }


}

