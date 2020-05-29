//
//  TaskListViewControllerTests.swift
//  TodoAppTests
//
//  Created by Павел Алешин on 23.05.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import XCTest
@testable import TodoApp

class TaskListViewControllerTests: XCTestCase {
    
    var sut: TaskListViewController!

    override func setUpWithError() throws {
        super.setUp()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewController = storyBoard.instantiateViewController(identifier: String(describing: TaskListViewController.self))
        
        sut = viewController as? TaskListViewController
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWhenViewLoadedTableViewNotNill() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func testWhenViewIsLoadedDataProviderIsNotNil() {
        XCTAssertNotNil(sut.dataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDelegateIsSet() {
        XCTAssertTrue(sut.tableView.delegate is DataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDataSourceIsSet() {
        XCTAssertTrue(sut.tableView.dataSource is DataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDelegateEqualsTablViewDataSource() {
        XCTAssertEqual(sut.tableView.dataSource as? DataProvider, sut.tableView.delegate as? DataProvider)
    }
    
    func testTaskListViewControllerHasAddBarButtonWithSelfAsTarget() {
        let target = sut.navigationItem.rightBarButtonItem?.target
        XCTAssertEqual(target as? TaskListViewController, sut)
    }
    
    func presentingNewTaskViewController() -> NewTaskViewController {
        guard
                   let newTaskButton = sut.navigationItem.rightBarButtonItem,
                   let action = newTaskButton.action
               else {
                  
                   return NewTaskViewController()
               }
               
               UIApplication.shared.keyWindow?.rootViewController = sut
               
               sut.performSelector(onMainThread: action, with: newTaskButton, waitUntilDone: true)
        let newTaskViewController = sut.presentedViewController as! NewTaskViewController
               return newTaskViewController
              
    }
    
    func testAddNewTaskPresentsNewTaskViewController() {
        //XCTAssertNotNil(sut.presentedViewController)
        let newTaskViewController = presentingNewTaskViewController()
        XCTAssertNotNil(newTaskViewController.titleTextField)
    }
    
    func testSharesSameTaskManagerWithNewTaskViewController() {
        
        let newTaskViewController = presentingNewTaskViewController()
        XCTAssertNotNil(sut.dataProvider.taskManager)
        //=== делает сравнение тот же ли это объект. == сравнивает 2 объектра между собой
        //если ссылка будте nil, будет  true
        XCTAssertTrue(newTaskViewController.taskManager === sut.dataProvider.taskManager)
    }
    
    //как только появляется TaskLiastViewController нужно перезагрузить tableView
    func testWhenViewAppearedTableViewReloaded() {
        let moockTableView = MockTableView()
        sut.tableView = moockTableView
        //вызываем метод viewWillAppear через beginAppearanceTransition
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        XCTAssertTrue((sut.tableView as! MockTableView).isReloaded)
        
    }
    
}


extension TaskListViewControllerTests {
    class MockTableView: UITableView {
        var isReloaded = false
        override func reloadData() {
            isReloaded = true
        }
    }
}
