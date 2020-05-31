//
//  TaskCellTests.swift
//  TodoAppTests
//
//  Created by Павел Алешин on 24.05.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import XCTest
@testable import TodoApp

class TaskCellTests: XCTestCase {

    var cell: TaskCell!
    
    override func setUpWithError() throws {
        super.setUp()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self))  as! TaskListViewController
        controller.loadViewIfNeeded()
        
        let tableView =  controller.tableView
        let dataSource = FakeDataSource()
        tableView?.dataSource = dataSource
        
         cell = tableView?.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self), for: IndexPath(row: 0, section: 0)) as? TaskCell
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCellHasTitleLabel() {
        
        XCTAssertNotNil(cell.titleLabel)
    }
    
    func testCellHastitleLabelInContentView() {
        //isDescendant проверяет находится ли title внутри ячейки
        XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
    }
    
    func testCellHasLocationLabel() {
        
        XCTAssertNotNil(cell.locationLabel)
    }
    
    func testCellHasLocationLabelInContentView() {

        XCTAssertTrue(cell.locationLabel.isDescendant(of: cell.contentView))
    }
    
    func testCellHasDateLabel() {
        
        XCTAssertNotNil(cell.dateLabel)
    }
    
    func testCellHasDateLabelInContentView() {

        XCTAssertTrue(cell.dateLabel.isDescendant(of: cell.contentView))
    }
    
    func testConfigureSetsTitle() {
        let task = Task(title: "foo")
        cell.configure(with: task)
        
        XCTAssertEqual(cell.titleLabel.text, task.title)
    }
    
    func testConfigureSetsDate() {
        let task = Task(title: "foo")
        
        cell.configure(with: task)
        
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        
        let date = task.date
        
        let dateString = df.string(from: date)
        
        XCTAssertEqual(cell.dateLabel.text, dateString)
    }
    
    func testConfigureSetsLocationName() {
        
        let location = Location(name: "bar")
        let task = Task(title: "foo", location: location)
        
        cell.configure(with: task)
        
        XCTAssertEqual(cell.locationLabel.text, task.location?.name)
        
    }
    func configureCellWithTask() {
        let task = Task(title: "foo")
        cell.configure(with: task, done: true)
    }
    
    func testDoneTaskShouldstrikeThrough() {
        configureCellWithTask()
        
        let attributedString = NSAttributedString(string: "foo", attributes: [NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue])
        
        XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
    }
    
    func testDoneTaskDateLabelTextEqualsEmtyString() {
        configureCellWithTask()
        XCTAssertEqual(cell.dateLabel.text, "")
    }
    
    func testDoneTaskLocationLabelTextEqualsEmtyString() {
        configureCellWithTask() 
        XCTAssertEqual(cell.locationLabel.text, "")
    }

}


extension TaskCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
        
        
    }
}
