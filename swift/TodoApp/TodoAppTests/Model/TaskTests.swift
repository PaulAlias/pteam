//
//  TaskTests.swift
//  TodoAppTests
//
//  Created by Павел Алешин on 22.05.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import XCTest
@testable import TodoApp

class TaskTests: XCTestCase {
    
    func testInitTaskWithTitle() {
        
        let task = Task(title: "Foo")
        XCTAssertNotNil(task)
    }

    func testInitTaskWithTitleAndDescription() {
         
        let task = Task(title: "Foo", description: "Bar")
        XCTAssertNotNil(task)
    }
    
    func testWenGivenTitleSetsTilte() {
        let task = Task(title: "Foo")
        XCTAssertEqual(task.title, "Foo")
    }
    
    func testWenGivenDescriptionSetDescription() {
        let task = Task(title: "Foo", description: "Bar")
        XCTAssertEqual(task.description, "Bar")
    }
    
    func testTaskInitWithDate() {
        let task = Task(title: "Foo")
        XCTAssertNotNil(task.date)
    }
    
    func testWenGivenLoactionSetLoaction() {
        let location = Location(name: "Foo")
        
        let task = Task(title: "Foo", description: "Bar", location: location)
        
        XCTAssertEqual(location, task.location)
    }
    

}
