//
//  AddImageViewController.swift
//  Networking
//
//  Created by RomaDUlbich on 8/20/19.
//  Copyright © 2019 Oleg1. All rights reserved.
//

import UIKit

class AddImageViewController: UIViewController {

    @IBOutlet weak var imageCurrent: UIImageView!
    var client = NetworkClient()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButton(_ sender: Any) {
    //client.uploadImage()
        client.toAuth()
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
