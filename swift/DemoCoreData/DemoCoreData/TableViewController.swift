//
//  TableViewController.swift
//  DemoCoreData
//
//  Created by Павел Алешин on 21.03.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    var tasks: [Task] = []
    
    @IBAction func saveTask(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Новая задача", message: "Добавьте текст задачи", preferredStyle: .alert)
        
        
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { action in
            let tf = alertController.textFields?.first
            if let newTaskTitle = tf?.text {
                self.saveTask(withTite: newTaskTitle)
                self.tableView.reloadData()
            }
        }
        alertController.addTextField { _ in }
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func saveTask(withTite title: String) {
        let context = getContext()
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else { /*возврат ошибки*/ return }
        let TaskObject = Task(entity: entity, insertInto: context)
        
        TaskObject.title = title
        
        do {
            try context.save()
            //tasks.append(TaskObject)
            tasks.insert(TaskObject, at: 0)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    private func getContext () -> NSManagedObjectContext {
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let contex = getContext()
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        //let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        //fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            tasks = try contex.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        //полное очищение контекста в сущности Task
//        let context = getContext()
//        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
//        //получить контекст и удалить все из кор даты
//        if let objects = try? context.fetch(fetchRequest) {
//            for object in objects {
//                context.delete(object)
//            }
//        }
//        //сохранить весь контекст после удаления
//        do {
//            try context.save()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title

        return cell
    }
    
    //TODO:  понять как доделать правильно
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let ts = tasks[indexPath.row].title as? Task, editingStyle == .delete else { return }
        
        let context = getContext()
        
        context.delete(ts)
        
        do {
            try context.save()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
     }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
 

}
