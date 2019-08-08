//
//  ViewController.swift
//  Networking
//
//  Created by RomaDUlbich on 8/7/19.
//  Copyright © 2019 Oleg1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
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
                
                let course = try? JSONDecoder().decode(Image.self, from: data)
                print(course)
            }
            
        })
        
        task.resume()
        
    }
    
}





/*
 func doThom (){
 
 
 
 let defaultSession = URLSession.shared
 
 let url1 = URL(string: "https://api.imgur.com/3/gallery/top/viral/1")!
 var request = URLRequest(url: url1)
 request.setValue("Client-ID 3974f835c77d0ef", forHTTPHeaderField: "Authorization")
 
 let task = defaultSession.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
 
 guard error == nil else {
 
 return
 }
 
 guard let data = data else {
 return
 }
 
 var images = [Image]()
 
 do {
 //create json object from data
 if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
 if let gallery = json["images"] as? [String: Any]{
 if let galleryData = gallery["data"] as? [[String: Any]]{
 for dataPoint in galleryData{
 if let galleryObject = try? Image(json: dataPoint){
 images.append(galleryObject)
 }
 }
 }
 
 
 }
 
 
 for value in images{
 print(images.count)
 }
 
 print(json)
 }
 } catch let error {
 print(error.localizedDescription)
 }
 })
 task.resume()
 }
 */




// Do any additional setup after loading the view.








