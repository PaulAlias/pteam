//
//  DetailViewController.swift
//  TodoApp
//
//  Created by Павел Алешин on 24.05.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var deteLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var locationLabel: UILabel!
    
    var task: Task!
    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.titleLabel.text = task.title
        self.descriptionLabel.text = task.description
        self.locationLabel.text = task.location?.name
        self.deteLabel.text = dateFormatter.string(from: task.date)
        
        
        if let coordinate = task.location?.coordinate {
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
            
            mapView.region = region
        }
    }
}
