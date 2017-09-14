//
//  TrackTableViewCell.swift
//  AWSpotify
//
//  Created by Andrew LEE on 09/09/2017.
//  Copyright © 2017 Andrew LEE. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    @IBOutlet weak var trackLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.trackLabel.text = ""
    }
    
    func setupCell(track: Track) {
        self.trackLabel.text = track.name
    }

}
