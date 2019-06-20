//
//  ButtonParticle.swift
//  MyAPP
//
//  Created by kpugame on 20/06/2019.
//  Copyright © 2019 kpugame. All rights reserved.
//

import UIKit
import Foundation

class ButtonParticle: NSObject{
    
    @IBAction func onClick(_ sender: Any) {
        let mouseLoc = [NSEvent mouseLocation]
        
        let particle = ParticleView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        superview?.addSubview(particle)
    }
}
