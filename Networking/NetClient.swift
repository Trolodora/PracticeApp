//
//  NetClient.swift
//  Networking
//
//  Created by RomaDUlbich on 8/19/19.
//  Copyright © 2019 Oleg1. All rights reserved.
//

import Foundation
import Alamofire

class NetworkClient {
    let headers: HTTPHeaders = ["Authorization":"Client-ID 3974f835c77d0ef"]  
    
    
    func fetchImages(_ url: URL, completion:@escaping (_ galeries: Galleries)->Void){
        AF.request(url,headers: headers).validate().responseJSON{
            response in
            print(response)
            guard let data = response.data else {return}
            do{
                let myResponse = try JSONDecoder().decode(Galleries.self, from: data)
                completion(myResponse)
                print(myResponse)
                
            }
            catch{
                
            }
           
        }
            
        
    }
    
    }


