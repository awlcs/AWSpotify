//
//  AlbumViewController.swift
//  AWSpotify
//
//  Created by Andrew LEE on 09/09/2017.
//  Copyright © 2017 Andrew LEE. All rights reserved.
//

import UIKit
import PKHUD

class AlbumViewController: UIViewController {

    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var albumTitle: UILabel!
    @IBOutlet fileprivate weak var albumImageView: UIImageView!
    
    var session: SPTSession?
    var artist: Artist?
    var album: Album?
    
    
    fileprivate var wsClient = WebserviceClient()
    fileprivate var tracks = [Track]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        wsClient.delegate = self
        wsClient.session = self.session
        HUD.show(.progress)
        wsClient.getAlbumsListForArtistWith(identifier: (artist?.identifier)!)
    }
    
    func gotoTrackVC(selectedTrack: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TrackVC") as? TrackViewController
        if let vcUW = vc {
            vcUW.session = self.session
            vcUW.tracks = self.tracks
            vcUW.album = self.album
            vcUW.trackNumber = selectedTrack
            self.navigationController?.pushViewController(vcUW, animated: true)
        }
    }
    
    fileprivate func updateOutlets() {
        self.albumTitle.text = self.album?.name
        self.albumImageView.imageFromServerURL(urlString: (self.album?.imageUrl)!)
    }
    
    fileprivate func showAlertView() {
        let alertController = UIAlertController(title: nil, message: "You will be popped on previous screen because we have no albums of this artist on Spotify's database", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
            _ = self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


extension AlbumViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.gotoTrackVC(selectedTrack: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tracks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCellIdentifier", for: indexPath) as? TrackTableViewCell
        guard let cellUW = cell else {
            let cell = TrackTableViewCell()
            cell.setupCell(track: self.tracks[indexPath.row])
            return cell
        }
        cellUW.setupCell(track: self.tracks[indexPath.row])
        return cellUW
    }
}


extension AlbumViewController: WebserviceClientDelegate {
    func didReceiveDatas(inObject: AnyObject) {
        if inObject is [Track] {
            self.tracks = inObject as! [Track]
            
            if inObject.count == 0 {
                HUD.hide()
                self.showAlertView()
            }
            self.tableView.reloadData()
            HUD.hide()
        } else if inObject is [Album] {
            let array = inObject as! [Album]
            if inObject.count > 0 {
                self.album = array[0]
                guard let identifier = self.album?.identifier else { return }
                self.updateOutlets()
                self.wsClient.getTracksForAlbumtWith(identifier: identifier)
            } else {
                HUD.hide()
                self.showAlertView()
            }
        }
    }
    
    func didFailIntoError(inError: Error) {
        //Nothing, no time
        HUD.hide()
    }
}

