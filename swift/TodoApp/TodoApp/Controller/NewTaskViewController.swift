//
//  NewTaskViewController.swift
//  TodoApp
//
//  Created by Павел Алешин on 24.05.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit
import CoreLocation

class NewTaskViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var adressTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    @IBAction func save() {
        let titleString = titleTextField.text
        let locationString = locationTextField.text
        let date = dateFormater.date(from: dateTextField.text!)
        let descriptionString = descriptionTextField.text
        let adressString = adressTextField.text
        //замыкание выполняется с задержкой, чем метот dismiss, поэтому его нужно синхронизировать с мейн потоком и поместить в геокодер что бы выполнялся после заверщения всех задач геокодера
        geocoder.geocodeAddressString(adressString!) { [unowned self] (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            let placemarks = placemarks?.first
            let coordinate = placemarks?.location?.coordinate
            let location = Location(name: locationString!, coordinate: coordinate)
            let task = Task(title: titleString!, date: date, description: descriptionString, location: location)
            
            self.taskManager.add(task: task)
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        
    }
    
    var taskManager: TaskManager!
    var geocoder = CLGeocoder()
    
    var dateFormater: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
    
    
}
