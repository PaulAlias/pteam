//
//  DataProviderTasts.swift
//  TodoAppTests
//
//  Created by Павел Алешин on 23.05.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import XCTest
@testable import TodoApp

class DataProviderTests: XCTestCase {
    var sut: DataProvider!
    var tableView: UITableView!
    var controller: TaskListViewController!
    
    override func setUpWithError() throws {
         super.setUp()
        sut = DataProvider()
        sut.taskManager = TaskManager()
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        controller = (storyBoard.instantiateViewController(identifier: String(describing: TaskListViewController.self)) as? TaskListViewController)!
        
        controller.loadViewIfNeeded()
        
        tableView = controller.tableView
        tableView.dataSource = sut
        tableView.delegate = sut
        
    }
    
    override func tearDownWithError() throws {
        sut.taskManager?.removeAll()
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNumberOfSectionIsTwo() {
        let numberOfSection = tableView.numberOfSections
        
        XCTAssertEqual(numberOfSection, 2)
    }
    
    func testNumberOfRowsinSectionZeroIsTasksCount() {
        
        sut.taskManager?.add(task: Task(title: "foo"))
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.taskManager?.add(task: Task(title: "bar"))
        
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
        
    }
    
    func testNumberOfRowsinSectionOneIsDoneTasksCount() {
        
        sut.taskManager?.add(task: Task(title: "foo"))
        sut.taskManager?.checkTask(at: 0)
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        
        sut.taskManager?.add(task: Task(title: "bar"))
        sut.taskManager?.checkTask(at: 0)
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
        
    }
    
    func testCellForAllAtIndexPathReturnTaskCell() {
        sut.taskManager?.add(task: Task(title: "foo"))
        
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is TaskCell)
    }
    
    func testCellForRowAtIndexPathDequeuesCellFromTableView() {
        let mockTableView = MockTableView.mocTableView(with: sut)
        
        sut.taskManager?.add(task: Task(title: "foo"))
        
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(item: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellIsDequeued)
    }
    
    func testCellForRowInSectionZeroCallsConfigure() {
        let mockTableView = MockTableView.mocTableView(with: sut)
        
        let task = Task(title: "foo")
        sut.taskManager?.add(task: task )
        
        mockTableView.reloadData()
        
        let cell  = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockTaskCell
        XCTAssertEqual(cell.task, task)
        
    }
    
    func testCellForRowInSectionOneCallsConfigure() {
        let mockTableView = MockTableView.mocTableView(with: sut)
        
        let task = Task(title: "foo")
        let task2 = Task(title: "bar")
        sut.taskManager?.add(task: task)
        sut.taskManager?.add(task: task2)
        sut.taskManager?.checkTask(at: 0)
        mockTableView.reloadData()
        
        let cell  = mockTableView.cellForRow(at: IndexPath(item: 0, section: 1)) as! MockTaskCell
        XCTAssertEqual(cell.task, task)
        
    }
    
    func testDeleteButtonTitleSectionZeroShowsDone() {
        let buttonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(buttonTitle, "Done")
    }
    
    func testDeleteButtonTitleSectionOneShowsDone() {
        let buttonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 1))
        
        XCTAssertEqual(buttonTitle, "Undone")
    }
    
    func testCheckingTaskCheckInTaskManager() {
        let task = Task(title: "foo")
        sut.taskManager?.add(task: task)
        
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(sut.taskManager?.tasksCount, 0)
        XCTAssertEqual(sut.taskManager?.doneTasksCount, 1)
    }
    
    func testUncheckingTaskUncheckInTaskManager() {
        
        let task = Task(title: "foo")
        sut.taskManager?.add(task: task)
        sut.taskManager?.checkTask(at: 0)
        tableView.reloadData()
        
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 1))
        
        XCTAssertEqual(sut.taskManager?.tasksCount, 1)
        XCTAssertEqual(sut.taskManager?.doneTasksCount, 0)
        
    }
    
}

extension DataProviderTests {
    class MockTableView: UITableView {
        
        var cellIsDequeued = false
        
        static func mocTableView(with dataSource: UITableViewDataSource) -> MockTableView {
            let mockTableView = MockTableView(frame: CGRect(x: 0, y: 0, width: 375, height: 658), style: .plain)
            mockTableView.dataSource = dataSource
            
            mockTableView.register(MockTaskCell.self, forCellReuseIdentifier: String(describing: TaskCell.self))
            
            return mockTableView
        }
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellIsDequeued = true
            
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            
        }
    }
    
    class MockTaskCell: TaskCell {
        var task: Task?
        
        override func configure(with task: Task, done: Bool = false) {
            self.task = task
        }
    }
}
