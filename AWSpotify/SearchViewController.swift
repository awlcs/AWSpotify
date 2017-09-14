//
//  SearchViewController.swift
//  AWSpotify
//
//  Created by Andrew LEE on 08/09/2017.
//  Copyright © 2017 Andrew LEE. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    
    var session: SPTSession?
    fileprivate var artistsArray = [Artist]()
    
    var wsClient = WebserviceClient()
    var serializationClient = SerializationClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wsClient.delegate = self
        wsClient.session = self.session
        self.navigationItem.hidesBackButton = true
        
    }

    func gotoArtistVCWith(session: SPTSession, artist: Artist) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ArtistVC") as? AlbumViewController
        if let vcUW = vc {
            vcUW.session = session
            vcUW.artist = artist
            self.navigationController?.pushViewController(vcUW, animated: true)
        }
    }

}


extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.characters.count > 2) {
            //To get relevant results
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.wsClient.searchArtist(artistName: searchText)
        }
        if searchText.characters.count == 0 {
            self.artistsArray.removeAll()
            self.collectionView.reloadData()
        }
    }
}


extension SearchViewController: WebserviceClientDelegate {
    func didReceiveDatas(inObject: AnyObject) {
        if inObject is [Artist] {
            self.artistsArray =  inObject as! [Artist]
            self.collectionView.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }

    func didFailIntoError(inError: Error) {
        //Nothing, no time
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}



extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistCollectionViewCellIdentifier", for: indexPath) as? ArtistCollectionViewCell
        
        guard let cellUW = cell else {
            let cell = ArtistCollectionViewCell()
            cell.setupCell(artist: self.artistsArray[indexPath.row])
            return cell
        }
        cellUW.setupCell(artist: self.artistsArray[indexPath.row])
        return cellUW
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let artist = artistsArray[indexPath.row]
        guard let session = self.session else { print("no session"); return }
        self.gotoArtistVCWith(session: session, artist: artist)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artistsArray.count
    }
}
