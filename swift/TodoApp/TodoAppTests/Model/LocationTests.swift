//
//  LocationTests.swift
//  TodoAppTests
//
//  Created by Павел Алешин on 22.05.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import XCTest
import CoreLocation
@testable import TodoApp

class LocationTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitSetsCoordinates() {
        let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        
        let location = Location(name: "Foo", coordinate: coordinate)
        
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
        
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
    }
    
    func testInitSetName() {
        let location = Location(name: "Foo")
        XCTAssertEqual(location.name, "Foo")
        
    }
    
    func testCanBeCreatedFromPlistDictionary() {
        
        let location = Location(name: "baz", coordinate: CLLocationCoordinate2D(latitude: 10, longitude: 10))
 
        let dictionary: [String : Any] = ["name" : "baz",
                                    "latitude" : 10.0,
                                    "longitude" : 10.0]
        let createdLocation = Location(dict: dictionary)
        
        XCTAssertEqual(location, createdLocation)
        
    }
    
    func testCanbeSerializedintoDictionary() {
        let location = Location(name: "baz", coordinate: CLLocationCoordinate2D(latitude: 10, longitude: 10))
        
        let generatedLocation = Location(dict: location.dict)
        
        XCTAssertEqual(location, generatedLocation)
    }
    
    
}
