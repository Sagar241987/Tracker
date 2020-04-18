//
//  UserDetail.swift
//  LocationTracker
//
//  Created by Sagar Gupta on 18/04/20.
//  Copyright © 2020 Sagar Gupta. All rights reserved.
//

import Foundation
struct User{
    let username:String?
    let password:String?
}

class UserDetail:NSObject, NSCoding{
    
    var user:User?
    let USER_NAME = "username"
    let PASS_WORD = "username"
    required convenience init?(coder: NSCoder) {
        self.init()
        if let uName = coder.decodeObject(forKey: USER_NAME) as? String , let pass = coder.decodeObject(forKey: PASS_WORD) as? String{
            user = User(username: uName, password: pass)
        }
    }
    func encode(with coder: NSCoder) {
        if let user = user{
            coder.encode(user.username, forKey: USER_NAME)
            coder.encode(user.password, forKey: PASS_WORD)
        }
    }
    
    
}
class SaveUtils{
    
    class func archiveUser(user:User){
        
        //Save user credential
        let userObj = UserDetail()
        userObj.user = user
        let filename = "credential"
        let fullPath = getDocumentsDirectory().appendingPathComponent(filename)
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: userObj, requiringSecureCoding: false)
            try data.write(to: fullPath)
        } catch {
            print("Couldn't write file")
        }
        
    }
    class func unarchiveUser() -> UserDetail? {
        
        //Get user credential
        let filename = "credential"
        let fullPath = getDocumentsDirectory().appendingPathComponent(filename)
        
        if let nsData = NSData(contentsOf: fullPath) {
            do {
                let data = Data(referencing:nsData)
                let userDetail = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UserDetail
                return userDetail
            }
            catch {}
        }
        return nil
    }
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
