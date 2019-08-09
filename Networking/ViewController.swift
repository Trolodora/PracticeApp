//
//  ViewController.swift
//  Networking
//
//  Created by RomaDUlbich on 8/7/19.
//  Copyright © 2019 Oleg1. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let textCellIdentifier = "TextID"
    
    
    var galleries = [Gallery]()
    
    
    
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        super.viewDidLoad()       
        
        jsonQuery()
        
       
   
    }
    
    //MARK - Tableview setup
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return galleries.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath) as? CustomCell else{
            fatalError()
        }
  
        
        return cell
        
    }
    
    

    
    
    
    
    
    
    
    
    
    func jsonQuery(){
        
        var defSession = URLSession.shared
        let urlReq = URL(string: "https://api.imgur.com/3/gallery/top/viral/1")!
        var request = URLRequest(url: urlReq)
        request.setValue("Client-ID 3974f835c77d0ef", forHTTPHeaderField: "Authorization")
        
        
        
        let task = defSession.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else{
                return
            }
            guard let data = data else{
                return
            }
            
            do{
                
                let parseResult = try? JSONDecoder().decode(Galleries.self, from: data)
                self.galleries = parseResult!.data
                print(parseResult)
                print(self.galleries.count)
                
            }
        })
        
        task.resume()
    }

}














