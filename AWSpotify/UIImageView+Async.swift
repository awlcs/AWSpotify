//
//  UIImageView+Async.swift
//  AWSpotify
//
//  Created by Andrew LEE on 11/09/2017.
//  Copyright © 2017 Andrew LEE. All rights reserved.
//

import Foundation

//https://stackoverflow.com/questions/37018916/swift-async-load-image
//Credit to Shobhakar Tiwari
extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}
