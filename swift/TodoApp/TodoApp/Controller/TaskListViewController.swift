//
//  TaskListViewController.swift
//  TodoApp
//
//  Created by Павел Алешин on 22.05.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController {
    
    @IBOutlet var dataProvider: DataProvider!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let taskManager = TaskManager()
        dataProvider.taskManager = taskManager
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(showDetails(withNotification:)), name: NSNotification.Name(rawValue: "DidselectRow notification"), object: nil)
        
        //добавляем идентификатор вью
        view.accessibilityIdentifier = "mainView"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        if let viewController = storyboard?.instantiateViewController(identifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController {
            viewController.taskManager = self.dataProvider.taskManager
            present(viewController, animated: true, completion: nil)
        }
    }
    
    @objc func showDetails(withNotification notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let task = userInfo["task"] as? Task,
            let detailViewController = storyboard?.instantiateViewController(identifier: String(describing: DetailViewController.self)) as? DetailViewController
            else {
                fatalError()
        }
        
        detailViewController.task = task
        navigationController?.pushViewController(detailViewController, animated: true)
        
    }
}

