//
//  ViewController.swift
//  GetImageFromNetwork
//
//  Created by Павел Алешин on 24.04.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dowloadButton: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
    }

    @IBAction func dowloadButtonTapped(_ sender: UIButton) {
        label.isHidden = true
        dowloadButton.isEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        guard let url = URL(string: "https://www.iphones.ru/wp-content/uploads/2018/08/DA4C681C-230A-4786-B89D-7F5CB85312C1.jpeg") else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                //передаем данные изображение в main поток для обновления изображения приложения
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.imageView.image = image
                }
            }
        }.resume()
        
    }
    
}

