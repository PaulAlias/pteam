//
//  ImageViewController.swift
//  Networking
//

import UIKit
import Alamofire

class ImageViewController: UIViewController {
    
    private let url = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    private let largeUrl = "https://i.imgur.com/3416rvI.jpg"
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var completeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    
    func fetchImage() {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        NetworkManager.downloadImage(url: url) { (image) in
            
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
        }
    }
    
    func fetchImageWithAlamofire() {
    
        request(url).responseData { (responseData) in
            
            
            switch responseData.result {
                
            case .success(let data):
                 guard let image = UIImage(data: data) else { return }
                 self.activityIndicator.stopAnimating()
                 self.imageView.image = image
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func fetchDataWithAlamofire() {
        AlamofireNetworkRequest.downloadImage(url: url) { (image) in
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
        }
    }
    
    func downloadLargeImageWithProgress() {
        
        AlamofireNetworkRequest.onProgress = { progress in
            self.progressView.isHidden = false
            self.progressView.progress = Float(progress)
        }
        
        AlamofireNetworkRequest.completed = { completed in
            self.completeLabel.isHidden = false
            self.completeLabel.text = completed
        }
        
        AlamofireNetworkRequest.downloadImageWithProgress(url: largeUrl) { (image) in
            self.activityIndicator.stopAnimating()
            self.completeLabel.isHidden = true
            self.progressView.isHidden = true
            self.imageView.image = image
        }
    }
    
    

    
}
