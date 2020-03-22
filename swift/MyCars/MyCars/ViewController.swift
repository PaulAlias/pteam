//
//  ViewController.swift
//  MyCars
//
//  Created by Ivan Akulov on 08/02/20.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var context: NSManagedObjectContext!
    var car: Car!
    
    lazy var dateFormater: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .none
        return df
    }()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl! {
        didSet {
            updateSegmentedControl()
            
            //цвет выделеной ячейки поумолчанию
            segmentedControl.selectedSegmentTintColor = .white
            
            //добавление атрибутов (цвет) для текста
            let whiteTitleTextAtributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            let blackTitleTextAtributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            
            //выбор цвета текста для остальных ячеек
            UISegmentedControl.appearance().setTitleTextAttributes(whiteTitleTextAtributes, for: .normal)
            //выбор цвета текста для выделеной ячейки
            UISegmentedControl.appearance().setTitleTextAttributes(blackTitleTextAtributes, for: .selected)
        }
        
    }
    
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var lastTimeStartedLabel: UILabel!
    @IBOutlet weak var numberOfTripsLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var myChoiceImageView: UIImageView!
    
    @IBAction func segmentedCtrlPressed(_ sender: UISegmentedControl) {
        updateSegmentedControl()
    }
    
    @IBAction func startEnginePressed(_ sender: UIButton) {
        car.timesDriven += 1
        car.lastStarted = Date()
        
        do {
            try context.save()
            insertDataFrom(selectedCar: car)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func rateItPressed(_ sender: UIButton) {
        let alertContoller = UIAlertController(title: "Поставить оценку", message: "Выставьте оценку авто", preferredStyle: .alert)
        let rateAction = UIAlertAction(title: "Оценить", style: .default) { action in
            //Достаем текст из алерта
            if let text = alertContoller.textFields?.first?.text {
                self.update(rating: (text as NSString).doubleValue)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)
        
        alertContoller.addTextField { textField in
            //даем возомжнсть ввести только цифры
            textField.keyboardType = .numberPad
        }
        
        alertContoller.addAction(rateAction)
        alertContoller.addAction(cancelAction)
        
        present(alertContoller, animated: true, completion: nil)
    }
    
    private func updateSegmentedControl () {
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        let mark = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        fetchRequest.predicate = NSPredicate(format: "mark == %@", mark!)
        
        do {
            let results = try context.fetch(fetchRequest)
            car = results.first
            insertDataFrom(selectedCar: car!)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func update(rating: Double) {
        car.rating = rating
        
        do {
            try context.save()
            insertDataFrom(selectedCar: car)
        } catch let error as NSError {
            let alertController = UIAlertController(title: "Не верное значение оценки", message: "Поставьте оценку от 0 до 10", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            
            alertController.addAction(okAction)
            present(alertController, animated: true)
            print(error.localizedDescription)
        }
    }
    
    //вводит данные в интерфейс
    private func insertDataFrom(selectedCar car: Car) {
        carImageView.image = UIImage(data: car.imageData!) // добавить правильный гвард или заглушку картинки дефолтную
        markLabel.text = car.mark
        modelLabel.text = car.model
        myChoiceImageView.isHidden = !(car.myChoice)
        ratingLabel.text = "Rating: \(car.rating) / 10"
        numberOfTripsLabel.text = "Number of trips: \(car.timesDriven)"
        lastTimeStartedLabel.text = "Last time started: \(dateFormater.string(from: car.lastStarted!))"
        //выбор цвета и присвоение его меню segmentedControl
        segmentedControl.backgroundColor = car.tintColor as? UIColor
        
    }
    
    private func getDataFromFile() {
        
        //TODO: -1- проверка есть ли данные в базе(хардкор)
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        //получить данные кторорые нужны для проверки
        fetchRequest.predicate = NSPredicate(format: "mark != nil")
        
        var records = 0
        
        do {
            records = try context.count(for: fetchRequest)
            print("Is Data there already?")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        guard records == 0 else { return }
        //-1-
        
        guard let pathToFile = Bundle.main.path(forResource: "data", ofType: "plist"),
            //удобный вывод данных из массива который хранится в файле .plist 
            let dataArray = NSArray(contentsOfFile: pathToFile) else { return }
        
        for dictionary in dataArray {
            guard let entity = NSEntityDescription.entity(forEntityName: "Car", in: context) else { return }
            let car = NSManagedObject(entity: entity, insertInto: context) as! Car
            
            // т.к наш словарь из файла имеет вид Строка: разные данные
            let carDictionary = dictionary as! [String: AnyObject]
            car.mark = carDictionary["mark"] as? String
            car.model = carDictionary["model"] as? String
            car.rating = carDictionary["rating"] as! Double
            car.lastStarted = carDictionary["lastStarted"] as? Date
            car.timesDriven = carDictionary["timesDriven"] as! Int16
            car.myChoice = carDictionary["myChoice"] as! Bool
            
            let imageName = carDictionary["imageName"] as? String
            let image = UIImage(named: imageName!)
            let imageData = image!.pngData()
            car.imageData = imageData
            
            if let colorDictionary = carDictionary["tintColor"] as? [String: Float] {
                
                car.tintColor = getColor(colorDictionary: colorDictionary)
            }
        }
    }
    
    private func getColor (colorDictionary: [String: Float]) -> UIColor {
        
        guard let red = colorDictionary["red"],
            let green = colorDictionary["green"],
            let blue = colorDictionary["blue"] else { return UIColor() }
        
        return UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: через user.dafaults  сделать проверку запускалось ли приложение или нет. если запускалось не выполнять getDataFromFile()
        getDataFromFile()
        
    }
    
    
}

