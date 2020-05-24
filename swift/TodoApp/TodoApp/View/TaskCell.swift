//
//  TaskCell.swift
//  TodoApp
//
//  Created by Павел Алешин on 23.05.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private var dateFormater: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        
        return df
    }
    
    
    func configure(with task: Task, done: Bool = false) {
        
        if done {
            let attributedString = NSAttributedString(string: task.title, attributes: [NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue])
            titleLabel.attributedText = attributedString
            dateLabel = nil
            locationLabel = nil
        } else {
                let dateString = dateFormater.string(from: task.date)
                dateLabel.text = dateString
            
            self.titleLabel.text = task.title
            self.locationLabel.text = task.location?.name
            
        }
        
    }

}
