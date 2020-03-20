//
//  MainPresenterTest.swift
//  mvpUnitTestTests
//
//  Created by Павел Алешин on 20.03.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import XCTest
@testable import mvpUnitTest

class MockView: MainViewProtocol {
    var titleTest: String?
    func setGreeting(greeting: String) {
        self.titleTest = greeting
    }
    
    
}

class MainPresenterTest: XCTestCase {
    
    var view: MockView!
    var person: Person!
    var presenter: MainPresenter!
    
    
    override func setUp() {
        view = MockView()
        person = Person(firstName: "foo", lastName: "bar")
        presenter = MainPresenter(view: view, person: person)
    }

    override func tearDown() {
        view = nil
        person = nil
        presenter = nil
    }

    func testModuleIsNotNill() {
        XCTAssertNotNil(view, "view is not nil")
        XCTAssertNotNil(person, "person is not nil")
        XCTAssertNotNil(presenter, "presenter is not nil")
    }
    
    func testView() {
        presenter.showGreeting()
        XCTAssertEqual(view.titleTest, "foo bar")
    }
    
    func testPerson() {
        XCTAssertEqual(person.firstName, "foo")
        XCTAssertEqual(person.lastName, "bar")
    }

}
