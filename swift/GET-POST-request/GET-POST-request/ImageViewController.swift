//
//  ImageViewController.swift
//  GET-POST-request
//
//  Created by Павел Алешин on 24.04.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.isHidden = true
        indicator.hidesWhenStopped = true
        fetchImage() 
    }
    
    func fetchImage() {
        
        indicator.isHidden = false
        indicator.startAnimating()
        
        guard let url = URL(string: "https://avatars.mds.yandex.net/get-pdb/1767541/efb06b31-1022-458e-b773-8e051f3a1903/s1200") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) {[weak self] (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.indicator.stopAnimating()
                    self?.imageView.image = image
                }
            }
        }.resume()
    }
}
