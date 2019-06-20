//
//  StartView.swift
//  MyAPP
//
//  Created by kpugame on 03/06/2019.
//  Copyright © 2019 kpugame. All rights reserved.
//

import UIKit

class StartView: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: view)
            print(position)
            let p = ParticleView(frame: CGRect(x: 10, y: 20, width: 338, height: 55))
            view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            view.addSubview(p)
            view.bringSubviewToFront(p)
            print(view.subviews)
        
        }
        
        
    }

}
