//
//  LoginVC.swift
//  LocationTracker
//
//  Created by Sagar Gupta on 18/04/20.
//  Copyright © 2020 Sagar Gupta. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var userNameTxtF: UITextField!
    @IBOutlet weak var passwordTxtF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        Thread.sleep(forTimeInterval: 2.0)
        setUpView()
        // Do any additional setup after loading the view.
    }
    func setUpView() {
        
        bgView.addShadow()
        loginBtn.addShadow()
        userNameTxtF.attributedPlaceholder = NSAttributedString(string: "Username",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        passwordTxtF.attributedPlaceholder = NSAttributedString(string: "Password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        if SaveUtils.unarchiveUser() == nil{
            loginBtn.setTitle("SIGN UP", for: .normal)
        }else{
            if Utility.isLogin(){
                self.performSegue(withIdentifier: "mapSegue", sender: self)
            }
        }
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(recognizeTap(with:)))
        self.view.addGestureRecognizer(recognizer)
        
    }
    @objc func recognizeTap(with recognizer: UITapGestureRecognizer) {
        userNameTxtF.resignFirstResponder()
        passwordTxtF.resignFirstResponder()
    }
    @IBAction func loginResponder(_ sender: Any) {
        
        if userNameTxtF.text?.isEmpty == true{
           Utility.displayAlert(title: "", message: "Please enter the username", view: self)
            return
        }
        if passwordTxtF.text?.isEmpty == true{
            Utility.displayAlert(title: "", message: "Please enter the password", view: self)
            return
        }
        if let userDetail = SaveUtils.unarchiveUser() {
            if userDetail.user?.username == userNameTxtF.text &&   userDetail.user?.password == passwordTxtF.text{
                Utility.displayAlert(title: "Location tracker is welcoming you", message: "", view: self, actions: ["Ok"], completion: {
                    mesage in
                    if mesage == "Ok" {
                        Utility.setLogin()
                        self.userNameTxtF.text = ""
                        self.passwordTxtF.text = ""
                        self.performSegue(withIdentifier: "mapSegue", sender: self)
                    }
                })
            }else{
                Utility.displayAlert(title: "Incorrect username & password", message: "", view: self)
            }
        }else{
            let user = User(username: userNameTxtF.text, password: userNameTxtF.text)
            SaveUtils.archiveUser(user: user)
                Utility.displayAlert(title: "Thanks for registration. Please use your login credential for login", message: "", view: self, actions: ["Ok"], completion: {
                    mesage in
                    if mesage == "Ok" {
                        self.loginBtn.setTitle("SIGN IN", for: .normal)
                        self.userNameTxtF.text = ""
                        self.passwordTxtF.text = ""
                        self.userNameTxtF.becomeFirstResponder()
                        self.dismiss(animated: true)
                    }
                })
        }
        
    }
    @IBAction func signupResponder(_ sender: Any) {
    }


}

