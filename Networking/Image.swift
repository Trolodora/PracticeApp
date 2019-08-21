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
    let data: [Gallery]
    enum CodingKeys: String, CodingKey{
        case data
    }    
}

struct Gallery : Codable{
    var title : String
    let images : [Img]?
    enum CodingKeys: String, CodingKey {
        case title
        case images
    }
}

struct Img : Codable{
    var link : String
    enum CodingKeys: String, CodingKey {
        case link
    }
}





    
 
