//
//  Artist.swift
//  AWSpotify
//
//  Created by Andrew LEE on 08/09/2017.
//  Copyright © 2017 Andrew LEE. All rights reserved.
//

import Foundation
import JSONCodable

struct Artist {
    var name: String
    var imageUrl: String
    var identifier: String
}

extension Artist: JSONDecodable {
    fileprivate enum JSONKeys {
        static let name = "name"
        static let image = "image"
        static let identifier = "id"
    }
    
    
    public init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        name = try decoder.decode(JSONKeys.name)
        
        let array = object["images"] as? [JSONObject]
        var imgUrl: String = ""
        for dict: JSONObject in array! {
            if let widthUW = dict["width"] as? Int {
                if widthUW == 300 {
                    if let theUrl = dict["url"] as? String{
                        imgUrl = theUrl
                    }
                    break
                }
            }
        }
        
        imageUrl = imgUrl
        identifier = try decoder.decode(JSONKeys.identifier)
    }
    
    
}
