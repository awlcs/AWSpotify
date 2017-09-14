//
//  TrackViewController.swift
//  AWSpotify
//
//  Created by Andrew LEE on 09/09/2017.
//  Copyright © 2017 Andrew LEE. All rights reserved.
//

import UIKit
import AVFoundation

class TrackViewController: UIViewController {

    @IBOutlet fileprivate weak var trackImageView: UIImageView!
    @IBOutlet fileprivate weak var trackLabel: UILabel!
    @IBOutlet fileprivate weak var playPauseButton: UIButton!
    @IBOutlet fileprivate weak var nextTrackButtton:UIButton!
    @IBOutlet fileprivate weak var previousTrackButton: UIButton!
    
    var tracks: [Track]?
    var album: Album?
    var trackNumber: Int = 0
    var session: SPTSession?
    
    fileprivate var player = AVPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupOutlets()
        self.setupPlayer()
    }
    
    func setupPlayer() {
        let track = self.tracks?[self.trackNumber]
        self.player =  AVPlayer(url: URL(string: (track?.previewUrl)!)!)
        self.player.play()
        
        self.trackLabel.text = track?.name
    }
    
    func setupOutlets() {
        let track = self.tracks?[self.trackNumber]
        self.trackImageView.imageFromServerURL(urlString: album!.imageUrl)
        self.trackLabel.text = track?.name
        if self.trackNumber == 0 {
            self.previousTrackButton.isEnabled = false
        } else  if self.trackNumber + 1 == self.tracks?.count {
            self.nextTrackButtton.isEnabled = false
        }
    }
    
    @IBAction func previousAction(_ sender: Any) {
        if self.trackNumber != 0 {
            self.trackNumber = self.trackNumber - 1
            self.setupPlayer()
        }
        self.updateButtons()
    }
    
    @IBAction func playPause(_ sender: UIButton) {
        if (self.player.rate != 0 && self.player.error == nil) {
            self.player.pause()
            self.playPauseButton.setTitle("Play", for: .normal)
        } else {
            self.player.play()
            self.playPauseButton.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        if self.trackNumber < (self.tracks?.count)! - 1  {
            self.trackNumber = self.trackNumber + 1
            self.setupPlayer()
        }
        self.updateButtons()
    }
    
    private func updateButtons() {
        if self.trackNumber == 0 {
            self.nextTrackButtton.isEnabled = true
            self.previousTrackButton.isEnabled = false
        } else if self.trackNumber == (self.tracks?.count)! - 1 {
            self.nextTrackButtton.isEnabled = false
            self.previousTrackButton.isEnabled = true
        } else if self.trackNumber  > 0 && self.trackNumber < (self.tracks?.count)! {
            self.nextTrackButtton.isEnabled = true
            self.previousTrackButton.isEnabled = true
            
        }
    }
}
