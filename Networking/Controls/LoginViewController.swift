//
//  LoginViewController.swift
//  Networking
//
//  Created by RomaDUlbich on 8/22/19.
//  Copyright © 2019 Oleg1. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usserPass: UITextField!
    let pasKey = "a"    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func checkLogin(password: String) -> Bool{
        return password == pasKey
    }
    @IBAction func presLog(_ sender: Any) {
        if checkLogin(password: usserPass.text!){
            performSegue(withIdentifier: "show", sender: self)
        }
        else{
            print("ban")
        }
        
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
