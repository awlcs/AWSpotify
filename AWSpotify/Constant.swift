//
//  Constant.swift
//  AWSpotify
//
//  Created by Andrew LEE on 08/09/2017.
//  Copyright © 2017 Andrew LEE. All rights reserved.
//

import Foundation

enum Constants {
    static let clientId = "9f8b79de33564150905844f5e42daa42"
    static let searchArtistUrl = "https://api.spotify.com/v1/search?q="
    static let searchSubArtistUrl = "&type=artist&access_token="
    static let artistAlbumsListUrl = "https://api.spotify.com/v1/artists/"
    static let subArtistAlbumsListUrl = "/albums?album_type=album&access_token="
    static let tracksForAlbumUrl = "https://api.spotify.com/v1/albums/"
    static let subTracksForAlbumUrl = "/tracks?access_token="
}
