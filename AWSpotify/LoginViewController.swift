//
//  LoginViewController.swift
//  AWSpotify
//
//  Created by Andrew LEE on 09/09/2017.
//  Copyright © 2017 Andrew LEE. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    @IBOutlet fileprivate weak var loginButton: UIButton!
    
    fileprivate var auth = SPTAuth.defaultInstance()!
    fileprivate var session:SPTSession! 
    fileprivate var loginUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.updateLoginSession), name: NSNotification.Name(rawValue: "loginSuccessful"), object: nil)
    }

    func setup () {
        let redirectURL = "com.awlcs.AWSpotify://returnAfterLogin"
        let clientID = "a963c5d554dc4fa58819e8b6da631ca4"
        auth.redirectURL     = URL(string: redirectURL)
        auth.clientID        = clientID
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
        loginUrl = auth.spotifyWebAuthenticationURL()
        
    }
    
    func updateLoginSession () {
        loginButton.isHidden = true
        let userDefaults = UserDefaults.standard
        
        if let sessionObj:AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            self.session = firstTimeSession
            self.gotoSearchVCWith(session: self.session)
            
        }
    }
    
    func gotoSearchVCWith(session: SPTSession) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchArtistVC") as? SearchViewController
        if let vcUW = vc {
            vcUW.session = session
            self.navigationController?.pushViewController(vcUW, animated: true)
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let loginUrlUW = loginUrl else { return }
        UIApplication.shared.open(loginUrlUW, options: [:], completionHandler: nil)
    }
    

}
