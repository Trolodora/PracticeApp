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
    
    var passwordItems: [KeychainPasswordItem] = []
    @IBOutlet weak var usserPass: UITextField!
    let createLoginButtonTag = 0
    let loginButtonTag = 1
    @IBOutlet weak var loginButton: UIButton!
    
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
            performSegue(withIdentifier: "show", sender: self)
        } else if sender.tag == loginButtonTag {
            if checkLogin(password: newPassword) {
                performSegue(withIdentifier: "show", sender: self)
            } else {
                showLoginFailedAlert()
            }
        }
        
    }
    
    
    
    
    
}
