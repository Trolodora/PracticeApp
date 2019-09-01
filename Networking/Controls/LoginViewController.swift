//
//  LoginViewController.swift
//  Networking
//
//  Created by RomaDUlbich on 8/22/19.
//  Copyright © 2019 Oleg1. All rights reserved.
//

import UIKit


struct KeychainConfiguration {
    static let serviceName = "Networking"
    static let accessGroup: String? = nil
}

class LoginViewController: UIViewController {
    static let NotificationLogin = NSNotification.Name(rawValue: "Done")
    
    @IBOutlet weak var touchIDButtn: UIButton!
    var passwordItems: [KeychainPasswordItem] = []
    @IBOutlet weak var usserPass: UITextField!
    let createLoginButtonTag = 0
    let loginButtonTag = 1
    @IBOutlet weak var loginButton: UIButton!
     var isTyping = false
    
    let touchIDstate = Biometrical()
    override func viewDidLoad() {
        super.viewDidLoad()
        let hasLogin = UserDefaults.standard.bool(forKey: "hasLoginKey")
    
        if hasLogin {
            loginButton.setTitle("OK", for: .normal)
            loginButton.tag = loginButtonTag
        } else {
            loginButton.setTitle("Create", for: .normal)
            loginButton.tag = createLoginButtonTag
        }
        
        touchIDButtn.isHidden = !touchIDstate.canEvaluatePolicy()
        
    }
    
    private func showLoginFailedAlert() {
        let alertView = UIAlertController(title: "Login Problem",
                                          message: "Wrong password.",
                                          preferredStyle:. alert)
        let okAction = UIAlertAction(title: "Try again", style: .default)
        alertView.addAction(okAction)
        present(alertView, animated: true)
    }
    
    func checkLogin(password: String) -> Bool{
        do {
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                    account: "user",
                                                    accessGroup: KeychainConfiguration.accessGroup)
            let keychainPassword = try passwordItem.readPassword()
            return password == keychainPassword
        } catch {
            fatalError("Error reading password from keychain - \(error)")
        }
    }
    
    
    @IBAction func presLog(_ sender: UIButton) {
        guard let newPassword = usserPass.text,
            !newPassword.isEmpty else {
                showLoginFailedAlert()
                return
        }
        usserPass.resignFirstResponder()
        if sender.tag == createLoginButtonTag {
            do {
                let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: "user",
                                                        accessGroup: KeychainConfiguration.accessGroup)
                try passwordItem.savePassword(newPassword)
            } catch {
                fatalError("Error updating keychain - \(error)")
            }
            UserDefaults.standard.set(true, forKey: "hasLoginKey")
            loginButton.tag = loginButtonTag
          //  NotificationCenter.default.post(name: LoginViewController.NotificationLogin, object: nil)
        } else if sender.tag == loginButtonTag {
            if checkLogin(password: newPassword) {
                 NotificationCenter.default.post(name: LoginViewController.NotificationLogin, object: nil)
            } else {
                showLoginFailedAlert()
            }
        }
        
    }
    
    
    @IBAction func touchDigit(_ sender: UIButton) {
       
        let currentPin = usserPass.text
        let pinDigit = sender.currentTitle!
        if isTyping{
            usserPass.text = currentPin! + pinDigit
        }
        else{
            usserPass.text = pinDigit
        }
        isTyping = true
    }
    
    @IBAction func touchIDAction(_ sender: Any) {
        touchIDstate.authenticateUser() { [weak self] message in
            // 2
            if let message = message {
                // if the completion is not nil show an alert
                let alertView = UIAlertController(title: "Error",
                                                  message: message,
                                                  preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Darn!", style: .default)
                alertView.addAction(okAction)
                self?.present(alertView, animated: true)
            } else {
                // 3
               NotificationCenter.default.post(name: LoginViewController.NotificationLogin, object: nil)
            }
        }
    
    }
    
    @IBAction func clearPin(_ sender: Any) {
        usserPass.text = ""
    }
    
}
