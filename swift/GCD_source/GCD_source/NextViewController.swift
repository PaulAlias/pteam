//
//  NextViewController.swift
//  GCD_source
//
//  Created by Павел Алешин on 30.03.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit


class NextViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        
        set {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchImage()
        
        asyncFetchImage(imageURL: URL(string: "https://pngimg.com/uploads/opel/opel_PNG6.png")!,
                        runQueue: .global(),
                        complitionQueue: .main) { (image, error) in
                            guard let image1 = image else { return }
                            self.image = image1
        }
        //        delay(3) {
        //            self.loginAlert()
        //        }
    }
    
    fileprivate func delay (_ delay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0)) {
            closure()
        }
    }
    
    fileprivate func loginAlert() {
        let ac = UIAlertController(title: "Зарегистрированы?", message: "Введите логин и пароль", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ок", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { (userNameTextField) in
            userNameTextField.placeholder = "Введите логин"
        }
        
        ac.addTextField { (userPasswordTextField) in
            userPasswordTextField.placeholder = "Введите пароль"
            userPasswordTextField.isSecureTextEntry = true
        }
        
        self.present(ac, animated: true, completion: nil)
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://pngimg.com/uploads/opel/opel_PNG6.png")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        //создем очередь для выполнения задачи пока крутится индикатор
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            //после того как все выполнено, добавляем в мейн поток картинку
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
    
    fileprivate func asyncFetchImage(imageURL: URL,
                                     runQueue: DispatchQueue,
                                     complitionQueue: DispatchQueue,
                                     complition: @escaping (UIImage?, Error?) -> ()) {
        runQueue.async {
            do{
                let data = try Data(contentsOf: imageURL)
                //если все отработало, то возвращаем данные картинки и нил в ошибке
                complitionQueue.async { complition(UIImage(data: data), nil) }
            } catch let error {
                //если ощибка, то возвращаем в данных картинки нил и ошибку
                complitionQueue.async { complition(nil, error) }
            }
        }
        
    }
    
}
