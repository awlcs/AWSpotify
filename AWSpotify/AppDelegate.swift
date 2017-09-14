//
//  AppDelegate.swift
//  AWSpotify
//
//  Created by Andrew LEE on 08/09/2017.
//  Copyright © 2017 Andrew LEE. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var auth = SPTAuth()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        auth.redirectURL     = URL(string: "com.awlcs.AWSpotify://returnAfterLogin")
        auth.sessionUserDefaultsKey = "current session"
        return true
    }
    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if auth.canHandle(auth.redirectURL) {
            auth.handleAuthCallback(withTriggeredAuthURL: url, callback: { (error, session) in
                
                if error != nil {
                    print("error!")
                }
                
                let userDefaults = UserDefaults.standard
                let sessionData = NSKeyedArchiver.archivedData(withRootObject: session) 
                
                userDefaults.set(sessionData, forKey: "SpotifySession")
                userDefaults.synchronize()
                NotificationCenter.default.post(name: Notification.Name(rawValue: "loginSuccessful"), object: nil)
            })
            return true
        }
        
        return false
        
        
    }


}

