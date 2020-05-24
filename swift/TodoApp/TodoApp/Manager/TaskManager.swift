//
//  TaskManager.swift
//  TodoApp
//
//  Created by Павел Алешин on 22.05.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import Foundation

class TaskManager {
    
    var tasksCount: Int {
        return tasks.count
    }
    var doneTasksCount: Int {
        return doneTasks.count
    }
    
    private var tasks: [Task] = []
    private var doneTasks: [Task] = []
    
    func add(task: Task){
        if !tasks.contains(task) {
        tasks.append(task)
        }
    }
    
    func task(at index: Int) -> Task{
        return tasks[index]
    }
    
    func checkTask(at index: Int) {
        let task = tasks.remove(at: index)
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
        let task = doneTasks.remove(at: index)
        tasks.append(task)
        
    }
}
