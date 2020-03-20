//
//  ModuleBuilder.swift
//  mvpUnitTest
//
//  Created by Павел Алешин on 20.03.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let person = Person(firstName: "David", lastName: "Blane")
        let view = MainViewController()
        let presenter = MainPresenter(view: view, person: person)
        view.presenter = presenter
        return view
    }
}
