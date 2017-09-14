//
//  SerializationClient.swift
//  AWSpotify
//
//  Created by Andrew LEE on 08/09/2017.
//  Copyright © 2017 Andrew LEE. All rights reserved.
//

import Foundation

private enum JSONKeys: String {
    case name = "name"
    case images = "images"
    case url = "url"
    case uri = "uri"
    case identifier = "identifier"
}

typealias JSONData = [String:AnyObject]

class SerializationClient {
    
    func parseArtists(inJSON: JSONData) -> [Artist]? {
        var array =  [Artist]()
    
        let arrayOfItems = inJSON["artists"]?["items"] as? [JSONData]
        guard let arrayOfItemsUW = arrayOfItems else { return array }
        for item: JSONData in arrayOfItemsUW {
            do {
                let artist = try Artist(object: item)
                array.append(artist)
            } catch {
                print("parse error")
            }
        }
        return array
    }
    
    func parseAlbums(inJSON: JSONData) -> [Album]? {
        var array = [Album]()
        
        let arrayOfItems = inJSON["items"] as? [JSONData]
        guard let arrayOfItemsUW = arrayOfItems else { return array }
        for item: JSONData in arrayOfItemsUW {
            do {
                let album = try Album(object: item)
                array.append(album)
            } catch {
                print("album parse error")
            }
        }
        return array
    }
    
    func parseTracks(inJSON: JSONData) -> [Track]? {
        var array = [Track]()
        
        let arrayOfItems = inJSON["items"] as? [JSONData]
        guard let arrayOfItemsUW = arrayOfItems else { return array }
        for item: JSONData in arrayOfItemsUW {
            do {
                let track = try Track(object: item)
                array.append(track)
            } catch {
                print("album parse error")
            }
        }
        return array
    }
}
