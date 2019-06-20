//
//  MidViewController.swift
//  MyAPP
//
//  Created by kpugame on 20/06/2019.
//  Copyright © 2019 kpugame. All rights reserved.
//

import UIKit

class MidViewController: UIViewController {

    var area: String = "1"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Send"{
            if let navController = segue.destination as? UIViewController{
                if let cont = navController as? night{
                    cont.area = area
                    print(area)
                }
            }
        }
        if segue.identifier == "Send2"{
            if let navController = segue.destination as? UIViewController{
                if let cont = navController as? Festival{
                    cont.area = area
                    print(area)
                }
            }
        }
    }
}
