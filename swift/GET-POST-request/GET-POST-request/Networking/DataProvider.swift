//
//  DataProvider.swift
//  GET-POST-request
//
//  Created by Павел Алешин on 29.04.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit

class DataProvider: NSObject {
    
    private var downloadTask: URLSessionDownloadTask!
    var fileLocation: ((URL) -> ())?
    var onProgress: ((Double) -> ())?
    
    private lazy var bgSession: URLSession = {
        //config определяет поведение сессии при загрузке и выгрузке данных
        //pTeam.GET-POST-request - bundle.identifire
        let config = URLSessionConfiguration.background(withIdentifier: "pTeam.GET-POST-request")
        //проверяет могут ли запланированные задачи работать по усмотрению системы
        //эпл рекомендует ставить true при больших объемов данных
        
        //config.isDiscretionary = true // опитимизация при загрузке данных(запуск задачи в опитимальное время, по wifi) (поумолчанию false)
        //config.timeoutIntervalForResource = 300 //  время ожидания сети в секундах
        config.waitsForConnectivity = true // Ожидания подключения к сети (поумолчанию true)
        //по завершению загрузки данных наше приложение запустится в фоновом режиме
        config.sessionSendsLaunchEvents = true
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
        
    }()
    
    func startDownload() {
        if let url = URL(string: "https://speed.hetzner.de/100MB.bin") {
            downloadTask = bgSession.downloadTask(with: url)
            //Задача начнет выполнятся не раньше заданного времени, через 3 секунды
            downloadTask.earliestBeginDate = Date().addingTimeInterval(3)
            downloadTask.countOfBytesClientExpectsToSend = 512
            downloadTask.countOfBytesClientExpectsToReceive = 100 * 1014 * 1024
            downloadTask.resume()
        }
    }
    
    func stopDownload() {
        downloadTask.cancel()
    }
    
    
}


extension DataProvider: URLSessionDelegate {
    //вызвается по завершению всех фоновых задач, из очереди с нашим идентификатором приложения
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let completionHandler = appDelegate.bgSessionCompletionHandler
                else { return }
            appDelegate.bgSessionCompletionHandler = nil
            completionHandler()
        }
    }
}

extension DataProvider: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        print("Did finish downloading: \(location.absoluteString)")
        
        DispatchQueue.main.async {
            self.fileLocation?(location)
        }
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
         guard totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown else { return }
        
        let progress =  Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        
        print("Download progress:  \(progress)")
        
        DispatchQueue.main.async {
            self.onProgress?(progress)
        }
    }
    
}
