//
//  ArtistCollectionViewCell.swift
//  AWSpotify
//
//  Created by Andrew LEE on 08/09/2017.
//  Copyright © 2017 Andrew LEE. All rights reserved.
//

import UIKit

class ArtistCollectionViewCell: UICollectionViewCell {
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var label: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.label.text = ""
        self.imageView.image = nil
    }
    
    func setupCell(artist: Artist) {
        self.imageView.imageFromServerURL(urlString: artist.imageUrl  )
        self.label.text = artist.name
    }
}
