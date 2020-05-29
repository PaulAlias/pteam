//
//  NewTaskViewControllerTests.swift
//  TodoAppTests
//
//  Created by Павел Алешин on 24.05.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import XCTest
import CoreLocation
@testable import TodoApp

class NewTaskViewControllerTests: XCTestCase {
    
    var sut: NewTaskViewController!
    var placemark: MockCLPlacemark!

    override func setUpWithError() throws {
         super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController
        sut.loadViewIfNeeded()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testHasTitleTextField() {
        XCTAssertTrue(sut.titleTextField.isDescendant(of: sut.view))
    }
    
    func testHasLocationTextField() {
        XCTAssertTrue(sut.locationTextField.isDescendant(of: sut.view))
    }
    
    func testHasDateTextField() {
           XCTAssertTrue(sut.dateTextField.isDescendant(of: sut.view))
       }
    
    func testHasAdressTextField() {
        XCTAssertTrue(sut.adressTextField.isDescendant(of: sut.view))
    }
    
    func testHasDescriptionTextField() {
        XCTAssertTrue(sut.descriptionTextField.isDescendant(of: sut.view))
    }
    
    func testHasSaveButton() {
        XCTAssertTrue(sut.saveButton.isDescendant(of: sut.view))
    }
    
    func testHasCancelButton() {
        XCTAssertTrue(sut.saveButton.isDescendant(of: sut.view))
    }
    
    func testSaveUsesGeocoderToConvertCoordinateFromAdress(){
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        let date = df.date(from: "01.01.20")
        
        sut.titleTextField.text = "foo"
        sut.locationTextField.text = "bar"
        sut.dateTextField.text = "01.01.20"
        sut.adressTextField.text = "Солнечногорск-7"
        sut.descriptionTextField.text = "baz"
        sut.taskManager = TaskManager()
        
        let mocGeocoder = MockCLGeocoder()
        sut.geocoder = mocGeocoder
        
        sut.save()
        
        
        let coordinate = CLLocationCoordinate2D(latitude: 56.1219206, longitude: 36.8695409)
        let location = Location(name: "bar", coordinate: coordinate)
        let generatedTask = Task(title: "foo", date: date, description: "baz", location: location)
        
        placemark = MockCLPlacemark()
        placemark.mockCoordinate = coordinate
        mocGeocoder.comletionHander?([placemark], nil)
        
        let task = sut.taskManager.task(at: 0)
        
        XCTAssertEqual(task, generatedTask)
    }
    
    func testSaveButtonHasSaveMethod() {
        let saveButton = sut.saveButton
        guard let actions = saveButton?.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(actions.contains("save"))
    }
    
    func testGeocoderFetchesCorrectCoordinate() {
        //содаем свойство которое давет возможность ожидания асинхронного ответа
        let geocoderAnswer = expectation(description: "Geocoder answer")
        let adressString = "Солнечногорск-7"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(adressString) { (placemarks, error) in
            let placemark = placemarks?.first
            let location = placemark?.location
            guard let latitude = location?.coordinate.latitude, let longitude = location?.coordinate.longitude else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(latitude, 56.1219206)
             XCTAssertEqual(longitude, 36.8695409)
            //ожидаем ответа
            geocoderAnswer.fulfill()
        }
        //ответ от сервера в течении 5 секунд
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //отпускается экран если добавлен новый таск
    func testSaveDissmissesNewTaskViewController() {
        
        //given
        //создаем экземпляр класса для проверки
        let mockNewTaskViewController = MockNewTaskViewController()
        //инициализируем все поля, т.к они не создаются на storyboard при сосздании через код, все поля равны nil
        mockNewTaskViewController.titleTextField = UITextField()
        mockNewTaskViewController.titleTextField.text = "foo"
        mockNewTaskViewController.descriptionTextField = UITextField()
        mockNewTaskViewController.descriptionTextField.text = "bar"
        mockNewTaskViewController.locationTextField = UITextField()
        mockNewTaskViewController.locationTextField.text = "baz"
        mockNewTaskViewController.adressTextField = UITextField()
        mockNewTaskViewController.adressTextField.text = "Солнечногорск-7"
        mockNewTaskViewController.dateTextField = UITextField()
        mockNewTaskViewController.dateTextField.text = "01.01.20"
        
        //when
        mockNewTaskViewController.save()
        
        //then
        //т.к задача добавляется с задержкой нужно дбавить и тут задержку
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            XCTAssertTrue(mockNewTaskViewController.isDismissed)
        }
        
        
    }
    
    

}

extension NewTaskViewControllerTests {
    class MockCLGeocoder: CLGeocoder {
        
        var comletionHander: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.comletionHander = completionHandler
        }
    }
    
    class MockCLPlacemark: CLPlacemark {
        
        var mockCoordinate: CLLocationCoordinate2D!
        
        override var location: CLLocation? {
            return CLLocation(latitude: mockCoordinate.latitude, longitude: mockCoordinate.longitude)
        }
    }
}

extension NewTaskViewControllerTests {
    class MockNewTaskViewController: NewTaskViewController {
        var isDismissed = false
        
        override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            isDismissed = true
        }
    }
}
