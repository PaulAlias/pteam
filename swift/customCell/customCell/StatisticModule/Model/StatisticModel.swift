//
//  StatisticModel.swift
//  customCell
//
//  Created by Павел Алешин on 01.04.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import Foundation

struct StatisticModel {
    
    //системные настроки
    var minimize: Bool?         //развернута карточка или нет
    var image: String?          //картинка группы запчастей цвета фона карточки
    var color: String?          //цвет уведомления
    
    //заполняемые пользователем свойства статистики
    var taskTitle: String?      //название задачи
    var partTitle: String?      //название запчасти
    var note: String?           //заметка о запчасти
    var partPrice: String?      //цена запчасти
    var reminder: Bool?         //напоминание
    var mileageChange: Int?     //замена при пробеге
    var vendorCode: String?     //артикул запачсти
    var servicePrice: Int?      //плата за работу
    var serviceTitle: String?   //название сервиса
    var salePrice: Int?         //скидка
    var resultPrice: Int?       //сумма за всю замену
    
    //заполняемые автоматически свойства статистики
    var regulations: Int?       //регламент замены
    var mileageCurrent: Int?    //текущий пробег авто
    var dateTaskStart: Date?    //дата создания задачи
    var dateTaskFinish: Date?   //дата завершения задачи
    var stateTask: Bool?        //завершена задача или нет
    
    
}
