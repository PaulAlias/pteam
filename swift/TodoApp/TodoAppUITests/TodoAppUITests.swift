//
//  TodoAppUITests.swift
//  TodoAppUITests
//
//  Created by Павел Алешин on 22.05.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import XCTest

class TodoAppUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append("--UITesting")
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.


        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testGeneratedCode() {
    
        XCTAssertTrue(app.isOnMainView)
        app.navigationBars["TodoApp.TaskListView"].buttons["Add"].tap()
        app.textFields["Title"].tap()
        app.textFields["Title"].typeText("foo")
        
        app.textFields["Location"].tap()
        app.textFields["Location"].typeText("bar")
        
        app.textFields["Adress"].tap()
        app.textFields["Adress"].typeText("Москва")
        
        app.textFields["Date"].tap()
        app.textFields["Date"].typeText("01.01.20")
        
        app.textFields["Description"].tap()
        app.textFields["Description"].typeText("baz")
        
        XCTAssertFalse(app.isOnMainView)
        app.buttons["save"].tap()
        
 
        // проверям появится ли в таблице статический текс foo
        XCTAssertTrue(app.tables.staticTexts["foo"].exists)
        XCTAssertTrue(app.tables.staticTexts["bar"].exists)
        XCTAssertTrue(app.tables.staticTexts["01.01.20"].exists)
        
    }
    
    func testWhenCellIsSwipedLeftDoneButtonApeared() {

        XCTAssertTrue(app.isOnMainView)
        app.navigationBars["TodoApp.TaskListView"].buttons["Add"].tap()
        app.textFields["Title"].tap()
        app.textFields["Title"].typeText("foo")
        
        app.textFields["Location"].tap()
        app.textFields["Location"].typeText("bar")
        
        app.textFields["Adress"].tap()
        app.textFields["Adress"].typeText("Москва")
        
        app.textFields["Date"].tap()
        app.textFields["Date"].typeText("01.01.20")
        
        app.textFields["Description"].tap()
        app.textFields["Description"].typeText("baz")
        
        XCTAssertFalse(app.isOnMainView)
        app.buttons["save"].tap()
        
        XCTAssertTrue(app.isOnMainView)
        
        // получаем содержимое таблицы, наши ячейки
        let tablesQuery = app.tables.cells
        tablesQuery.element(boundBy: 0).swipeLeft()
        //проверяем появилась ли кнопка Done
        tablesQuery.element(boundBy: 0).buttons["Done"].tap()
        
        // на нашем экране есть статический текст, текст содержится в элементе ярлык, с идентификатором date
        XCTAssertEqual(app.staticTexts.element(matching: .any, identifier: "date").label, "")
    }
    
}


extension XCUIApplication {
    var isOnMainView: Bool {
        
        return otherElements["mainView"].exists
    }
}
