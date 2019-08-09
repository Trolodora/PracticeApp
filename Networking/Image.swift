//
//  Track.swift
//  Networking
//
//  Created by RomaDUlbich on 8/7/19.
//  Copyright © 2019 Oleg1. All rights reserved.
//

import Foundation


struct Galleries : Codable
{
    var status  : Int
    let data: [Gallery]
    
   

    enum CodingKeys: String, CodingKey{
        
        case status
        case data
        
    }
  
    
   
}
struct Gallery : Codable{
  
    var title : String
   // let tags : [Tags]
 let images : [Img]?
    enum CodingKeys: String, CodingKey {
        case title
      
   case images
    }
}

struct Tags : Codable{
    var name : String?
    enum CodingKeys: String, CodingKey {
        case name
    }
}


 struct Img : Codable{
    var link : String
    enum CodingKeys: String, CodingKey {
        case link
    }

    
    
}


/*

    
   // eenum
   // case title = link
/*
    
    init(json:[String:Any])  {
        guard let title = json["title"] as? String else{
            fatalError()
        }
        guard let imageUrl = json["link"] as? URL else{
            fatalError("missingImg")
        }
        guard let userPostName = json["accountUrl"] as? String else{
            fatalError()
        }
        
        self.title = title
        self.imageUrl = imageUrl
        self.userPostName = userPostName
        
    }
    
    
    static func doTask( completion: @escaping([Image])->()){
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
            
            do {           //create json object from data
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
                    
                    print(json)
                    print("\(images.count) COUNT QUANTITY")
                }
            }
                
            catch let error {
                print(error.localizedDescription)
            }
            completion(images)
        })
        task.resume()
        
    }
    */
 */
