//
//  TaskManager.swift
//  TodoApp
//
//  Created by Павел Алешин on 22.05.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit

class TaskManager {
    
    private var tasks: [Task] = []
    private var doneTasks: [Task] = []
    
    var tasksCount: Int {
        return tasks.count
    }
    var doneTasksCount: Int {
        return doneTasks.count
    }
    
    var tasksUrl: URL {
        let fileUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentUrl = fileUrls.first else {
            fatalError()
        }
        
        return documentUrl.appendingPathComponent("tasks.plist")
        
    }
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(save), name:  UIApplication.willResignActiveNotification, object: nil)
        if let data = try? Data(contentsOf: tasksUrl) {
            let dictionaries  = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [[String : Any]]
            
            for dict in dictionaries! {
                if let task = Task(dict: dict) {
                    tasks.append(task)
                }
            }
        }
    }
    
    deinit {
        save()
    }
    
    
    @ objc func save() {
        let  taskDictionaries = self.tasks.map {$0.dict}
        guard taskDictionaries.count > 0 else {
            try? FileManager.default.removeItem(at: tasksUrl)
            return
        }
        
        let plistData = try? PropertyListSerialization.data(fromPropertyList: taskDictionaries, format: .xml, options: PropertyListSerialization.WriteOptions(0))
        
        try? plistData?.write(to: tasksUrl, options: .atomic)
    }
    
    func add(task: Task){
        if !tasks.contains(task) {
        tasks.append(task)
        }
    }
    
    func task(at index: Int) -> Task{
        return tasks[index]
    }
    
    func checkTask(at index: Int) {
        var task = tasks.remove(at: index)
        task.isDone.toggle()
        doneTasks.append(task)
        
    }
    
    func doneTasks(at index: Int) -> Task{
        return doneTasks[index]
    }
    
    func removeAll(){
        tasks.removeAll()
        doneTasks.removeAll()
    }
    
    func uncheckTask(at index: Int) {
        var task = doneTasks.remove(at: index)
        task.isDone.toggle()
        tasks.append(task)
        
    }
}
