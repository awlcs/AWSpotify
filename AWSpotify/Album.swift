//
//  Album.swift
//  AWSpotify
//
//  Created by Andrew LEE on 09/09/2017.
//  Copyright © 2017 Andrew LEE. All rights reserved.
//

import Foundation
import JSONCodable

struct Album {
    var identifier: String
    var name: String
    var imageUrl: String
}

extension Album: JSONDecodable {
    fileprivate enum JSONKeys {
        static let identifier = "id"
        static let name = "name"
    }
    
    init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        identifier = try decoder.decode(JSONKeys.identifier)
        name = try decoder.decode(JSONKeys.name)
        var imgUrl: String = ""
        let array = object["images"] as? [JSONObject]
        if let arrayUW = array {
            for dict: JSONObject in arrayUW {
                if let widthUW = dict["width"] as? Int {
                    if widthUW == 300 {
                        if let string = dict["url"] as? String {
                            imgUrl = string
                        }
                        break
                    }
                }
            }
            
        }
        imageUrl = imgUrl
    }
}
