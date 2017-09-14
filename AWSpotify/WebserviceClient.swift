//
//  WebserviceClient.swift
//  AWSpotify
//
//  Created by Andrew LEE on 08/09/2017.
//  Copyright © 2017 Andrew LEE. All rights reserved.
//

import Foundation
import Alamofire

protocol WebserviceClientDelegate: class {
    func didFailIntoError(inError: Error)
    func didReceiveDatas(inObject: AnyObject)
}



// reference
//https://github.com/Alamofire/Alamofire
//https://stackoverflow.com/questions/29852431/alamofire-asynchronous-completionhandler-for-json-request

class WebserviceClient {
    weak var delegate: WebserviceClientDelegate?
    var session: SPTSession?
    
    let serializationClient = SerializationClient()
    
    
    func searchArtist(artistName: String) {
        let stringUrl = Constants.searchArtistUrl + artistName + Constants.searchSubArtistUrl + (session?.accessToken!)!
        var array: [Artist]? = [Artist]()
        print(stringUrl)
        
        let queue = DispatchQueue(label: "com.cnoon.response-queue", qos: .utility, attributes: [.concurrent])
        
        Alamofire.request(stringUrl)
            .responseJSON (
                queue: queue,
                completionHandler: { response in
                    
                    if response.error != nil {
                        DispatchQueue.main.async {
                            self.delegate?.didFailIntoError(inError: response.error as! NSError)
                        }
                    } else {
                        if let json = response.result.value as? JSONData {
                            
                            array = self.serializationClient.parseArtists(inJSON: json )
                        }
                        guard let array = array else { return }
                        DispatchQueue.main.async {
                            self.delegate?.didReceiveDatas(inObject: array as AnyObject)
                        }
                    }
                    
            })
    }
    
    func getAlbumsListForArtistWith(identifier: String) {
        //http://api.spotify.com/v1/artists/4gzpq5DPGxSnKTe4SA8HAU/albums?album_type=album&access_token=BQDh-js3JS4aZr-976-5ivEOSJfEo_B49m-bIrI3TdeIYVlWIot09XPU-z8pKohXOUPXH4JD1lLH0YlNpMDe2YxmTHrTjIVIAhCskHs98T5J10pR6Ima-JCVmwn2XlTS36NjWqskMQ
        
        let stringUrl = Constants.artistAlbumsListUrl + identifier + Constants.subArtistAlbumsListUrl + (session?.accessToken!)!
        print(stringUrl)
        var array: [Album]? = [Album]()
        
        let queue = DispatchQueue(label: "com.cnoon.response-queue", qos: .utility, attributes: [.concurrent])
        
        Alamofire.request(stringUrl)
            .responseJSON (
                queue: queue,
                completionHandler: { response in
                    
                    if response.error != nil {
                        DispatchQueue.main.async {
                            self.delegate?.didFailIntoError(inError: response.error as! NSError)
                        }
                    } else {
                        if let json = response.result.value as? JSONData {
                            
                            array = self.serializationClient.parseAlbums(inJSON: json)
                        }
                        guard let array = array else { return }
                        DispatchQueue.main.async {
                            self.delegate?.didReceiveDatas(inObject: array as AnyObject)
                        }
                    }
            })
        
    }
    
    
    
    func getTracksForAlbumtWith(identifier: String) {
        //https://api.spotify.com/v1/albums/3cfAM8b8KqJRoIzt3zLKqw/tracks&access_token=BQDh-js3JS4aZr-976-5ivEOSJfEo_B49m-bIrI3TdeIYVlWIot09XPU-z8pKohXOUPXH4JD1lLH0YlNpMDe2YxmTHrTjIVIAhCskHs98T5J10pR6Ima-JCVmwn2XlTS36NjWqskMQ
        
        let stringUrl = Constants.tracksForAlbumUrl + identifier + Constants.subTracksForAlbumUrl + (session?.accessToken!)!
        print(stringUrl)
        var array: [Track]? = [Track]()
        
        let queue = DispatchQueue(label: "com.cnoon.response-queue", qos: .utility, attributes: [.concurrent])
        
        
        Alamofire.request(stringUrl)
            .responseJSON (
                queue: queue,
                completionHandler: { response in
                    
                    if response.error != nil {
                        DispatchQueue.main.async {
                            self.delegate?.didFailIntoError(inError: response.error as! NSError)
                        }
                    } else {
                        if let json = response.result.value as? JSONData {
                            
                            array = self.serializationClient.parseTracks(inJSON: json)
                        }
                        guard let array = array else { return }
                        DispatchQueue.main.async {
                            self.delegate?.didReceiveDatas(inObject: array as AnyObject)
                        }
                    }
            })
    }
}



