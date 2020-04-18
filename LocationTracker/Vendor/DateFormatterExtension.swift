//
//  DateFormatterExtension.swift
//  LocationTracker
//
//  Created by Sagar Gupta on 18/04/20.
//  Copyright © 2020 Sagar Gupta. All rights reserved.
//

import Foundation
extension Date{
    // Date to time format converter
    func dateToTimeConversion() -> String{
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "hh:mm a"
           let string = dateFormatter.string(from: self as Date)
           return string
       }
}
