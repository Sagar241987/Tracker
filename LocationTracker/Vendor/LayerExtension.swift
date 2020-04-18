//
//  LayerExtension.swift
//  LocationTracker
//
//  Created by Sagar Gupta on 18/04/20.
//  Copyright © 2020 Sagar Gupta. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    
    func addShadow(){
        
        self.layer.shadowColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5.0
        self.clipsToBounds = false
        
    }
}
