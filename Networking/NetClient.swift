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
    let headers: HTTPHeaders = ["Authorization":"Client-ID 8375cb219ab1c35"]
    let authUrl = URL(string: "https://api.imgur.com/oauth2/authorize?client_id=8375cb219ab1c35&response_type=token")
    let redirectUrl = URL(string: "com.networkApp://main")!
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
    
    func toAuth(){
        guard let url = authUrl else { return }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let redirectQuery = URLQueryItem(name: "redirect_url", value: redirectUrl.absoluteString)
        UIApplication.shared.open(components!.url!,options: [:], completionHandler: nil)
    }
    
    
    func uploadImage(){
         let image = UIImage(named: "duck")!
         let data = image.jpegData(compressionQuality: 1)
        let base64image = data?.base64EncodedString(options: .lineLength64Characters)
         let url = URL(string: "https://api.imgur.com/3/upload")!
        let parameters = [
            "image": base64image
        ]
        AF.upload(multipartFormData: { multipartFormData in
            if let data = image.jpegData(compressionQuality: 1){
                multipartFormData.append(data, withName: "username",fileName: "test.jpg", mimeType: "image/jpeg")
            }
            for (key, value) in parameters{
                multipartFormData.append((value?.data(using: .utf8))!,withName: key)
            }}, to: url, headers: headers).responseJSON(completionHandler: {completion in
                let json = try? JSONSerialization.jsonObject(with: completion.data!, options: .allowFragments) as? [String:Any]
                print(json!)
                
            })
        }
        
        
    }

