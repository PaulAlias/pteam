//
//  MainViewController.swift
//  GET-POST-request
//
//  Created by Павел Алешин on 25.04.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit
import UserNotifications

enum Actions: String, CaseIterable {
    case downloadImage = "Download"
    case get = "GET"
    case post = "POST"
    case ourCourses = "Our Courses"
    case uploadImage = "Upload Image"
    case downloadFile = "DownloadFile"
}
private let uploadImage = "https://api.imgur.com/3/image"
private let reuseIdentifier = "Cell"
private let url = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"

class MainViewController: UICollectionViewController {
    
//    let actions = ["Download", "GET", "POST", "Our Courses", "Upload Image"]
    let actions = Actions.allCases
    var alert: UIAlertController!
    private let dataProvider = DataProvider()
    private var filePath: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForNotification()
        
        dataProvider.fileLocation = { (location) in
            //save file
            print("Download finished: \(location.absoluteString)")
            self.alert.dismiss(animated: false, completion: nil)
            self.filePath = location.absoluteString
            self.postNotification()
        }
    }
    
    
    
    private func showAlert() {
        
        alert = UIAlertController(title: "Downloading...", message: "0%", preferredStyle: .alert)
        
        //что бы изменить размер алерта меняем констреенты с размерами по высоте, что бы влезли все элеметы
        //item - то к чему привязывется, attribute - выбираем констреинт, relatedBy - выбираем равно больше или меньше, toItem - то к чему цепляется,
        let height = NSLayoutConstraint(item: alert.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 170)
        
        alert.view.addConstraint(height)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
            
            self.dataProvider.stopDownload()
        }
        
        alert.addAction(cancelAction)
        present(alert, animated: true) {
            
            //определим размер activity indicator, стандартные значение 40х40
            let size = CGSize(width: 40, height: 40)
            //определим координаты по которым разместим индикатор, половину ширины алерта и высоты
            //посколько отображается индикатор от левого верхнего угла, что бы отцентровать надо половину высоты
            //и ширины индикатора вычесть
            //
            let point = CGPoint(x: self.alert.view.frame.width / 2 - size.width / 2, y: self.alert.view.frame.height / 2 - size.height / 2)
            
            let activityIndocator = UIActivityIndicatorView(frame: CGRect(origin: point, size: size))
            
            activityIndocator.color = .gray
            activityIndocator.startAnimating()
            
            //создадим  прогрес бар
            let progressView = UIProgressView(frame: CGRect(x: 0, y: self.alert.view.frame.size.height - 44 , width: self.alert.view.frame.size.width, height: 2))
            
            progressView.tintColor = .blue
            
            self.dataProvider.onProgress = { (progress) in
                
                progressView.progress = Float(progress)
                self.alert.message = String(Int(progress * 100)) + "%"
            }
            
            //добавим элементы  progressView, activityIndicator на алерт
            self.alert.view.addSubview(activityIndocator)
            self.alert.view.addSubview(progressView)
            
        }
        
        
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    //    override func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return actions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        cell.labelCell.text = actions[indexPath.row].rawValue
        
        return cell
    }
    
    //фиксируем ячейку по которой тапает пользователеть
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let action = actions[indexPath.row]
        
        switch action {
        case .downloadImage:
            performSegue(withIdentifier: "ShowImage", sender: self)
        case .get:
            NetworkManager.getRequest(url: url)
        case .post:
            NetworkManager.postRequest(url: url)
        case .ourCourses:
             performSegue(withIdentifier: "OurCourses", sender: self)
        case .uploadImage :
            NetworkManager.uploadImage(url: uploadImage)
        case .downloadFile:
            showAlert()
            dataProvider.startDownload()
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}


extension MainViewController {
    private func registerForNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (_, _) in
            
        }
    }
    
    private func postNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Downloading complete!"
        content.body = "File path: \(filePath!)"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "TransferComplete", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
