//
//  ShowDetailVC.swift
//  ArtCover
//
//  Created by Павел Алешин on 17/02/2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit

class ShowDetailVC: UIViewController {

    @IBOutlet weak var imageShowDetail: UIImageView!
    @IBOutlet weak var lableShowDetail: UILabel!
    
    var trackTltle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageShowDetail.image = UIImage(named: trackTltle)
        lableShowDetail.text = trackTltle
        lableShowDetail.numberOfLines = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
