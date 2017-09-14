//
//  Track.swift
//  AWSpotify
//
//  Created by Andrew LEE on 09/09/2017.
//  Copyright © 2017 Andrew LEE. All rights reserved.
//

import Foundation
import JSONCodable

struct Track {
    var type: String
    var previewUrl: String
    var uri: String
    var name: String
    var trackNumber: NSInteger
}

extension Track: JSONDecodable {
    fileprivate enum JSONKeys{
        static let type = "type"
        static let previewUrl = "preview_url"
        static let uri = "uri"
        static let name = "name"
        static let trackNumber = "track_number"
    }
    
    init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        type = try decoder.decode(JSONKeys.type)
        previewUrl = try decoder.decode(JSONKeys.previewUrl)
        uri = try decoder.decode(JSONKeys.uri)
        name = try decoder.decode(JSONKeys.name)
        trackNumber = try decoder.decode(JSONKeys.trackNumber)
    }
}
