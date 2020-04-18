//
//  Utility.swift
//  LocationTracker
//
//  Created by Sagar Gupta on 18/04/20.
//  Copyright © 2020 Sagar Gupta. All rights reserved.
//

import UIKit

class Utility {
    
  class func displayAlert(title: String , message : String , view : UIViewController, completion: @escaping () -> () = { }) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion()
        })
        alert.view.tintColor = app_color
        view.present(alert, animated: true, completion: nil)
    }
    
    class func displayAlert(title: String , message : String , view : UIViewController, actions: [String], completion: @escaping (String) -> ()) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        for action in actions {
            alert.addAction(UIAlertAction(title: action, style: .default) { _ in
                completion(action)
            })
        }
         alert.view.tintColor = app_color
        view.present(alert, animated: true)
    }
    
    class func setLogin(){
          UserDefaults.standard.set(true, forKey: "login")
    }
    
    class func isLogin() -> Bool{
        
        return UserDefaults.standard.bool(forKey: "login")
    }
   
}
