//
//  DetailViewControllerTests.swift
//  TodoAppTests
//
//  Created by Павел Алешин on 24.05.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import XCTest
import CoreLocation
@testable import TodoApp


class DetailViewControllerTests: XCTestCase {

    var sut: DetailViewController!
    
    override func setUpWithError() throws {
         super.setUp()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyBoard.instantiateViewController(identifier: String(describing: DetailViewController.self)) as? DetailViewController
         sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHasTitleLabel() {
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertNotNil(sut.titleLabel.isDescendant(of: sut.view))
    }
    
    func testHasDescriptionLabel() {
        XCTAssertNotNil(sut.descriptionLabel)
        XCTAssertNotNil(sut.descriptionLabel.isDescendant(of: sut.view))
    }
    
    func testHasDateLabel() {
        XCTAssertNotNil(sut.deteLabel)
        XCTAssertNotNil(sut.deteLabel.isDescendant(of: sut.view))
    }
    
    func testHasLocationLabel() {
        XCTAssertNotNil(sut.locationLabel)
        XCTAssertNotNil(sut.locationLabel.isDescendant(of: sut.view))
    }
    
    func testHasMapView() {
        XCTAssertNotNil(sut.mapView)
        XCTAssertNotNil(sut.mapView.isDescendant(of: sut.view))
    }
    
    func setupTaskAndAppearenceTransition() {
        let coordinate = CLLocationCoordinate2D(latitude: 56.22019453, longitude: 37.02547995)
        let location = Location(name: "baz", coordinate: coordinate)
        let date = Date(timeIntervalSince1970: 1577836800)
        let task = Task(title: "foo", date: date, description: "bar", location: location)
        
        sut.task = task
        //viewWillApear
        sut.beginAppearanceTransition(true, animated: true)
        //viewDidApear
        sut.endAppearanceTransition()
    }
    
    func testSettingTaskSetsTitleLabel() {
        setupTaskAndAppearenceTransition()
        XCTAssertEqual(sut.titleLabel.text, "foo")
    }
    
    func testSettingTaskSetsDescriptionLabel() {
        setupTaskAndAppearenceTransition()
        XCTAssertEqual(sut.descriptionLabel.text, "bar")
    }
    
    func testSettingTaskSetsLocationLabel() {
        setupTaskAndAppearenceTransition()
        XCTAssertEqual(sut.locationLabel.text, "baz")
    }
    
    func testSettingTaskSetsDateLabel() {
        setupTaskAndAppearenceTransition()
        XCTAssertEqual(sut.deteLabel.text, "01.01.20")
    }
    
    func testSettingTaskSetsMapView() {
        setupTaskAndAppearenceTransition()
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude, 56.22019453, accuracy: 0.001)
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude, 37.02547995, accuracy: 0.001)
    }
    
    


}
