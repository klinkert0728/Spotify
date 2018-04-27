//
//  ViewController.swift
//  Spotify
//
//  Created by Daniel Klinkert Houfer on 4/26/18.
//  Copyright © 2018 Daniel Klinkert Houfer. All rights reserved.
//

import UIKit
import SVProgressHUD
import SafariServices

class ViewController: BaseUIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsTableView: UITableView!
    var artistResult    = [Artist]()
    var albums          = [Album]()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        resultsTableView.delegate           = self
        resultsTableView.dataSource         = self
        searchBar.delegate                  = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        resultsTableView.estimatedRowHeight         = 100
        resultsTableView.rowHeight                  = UITableViewAutomaticDimension
        resultsTableView.tableFooterView            = UIView()
        title   = "Search for your favorite Artist"
    }
    
    //MARK: - Register Cell
    fileprivate func registerCells() {
        resultsTableView.register(UINib(nibName: "EmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "EmptyTableViewCell")
        resultsTableView.register(UINib(nibName: "ArtistTableViewCell", bundle: nil), forCellReuseIdentifier: "ArtistTableViewCell")
        resultsTableView.register(UINib(nibName: "AlbumTableViewCell", bundle: nil), forCellReuseIdentifier: "AlbumTableViewCell")
    }
    
    fileprivate func searchByQuery(query:String) {
        Artist.getArtist(query: query, successCallback: { (resultOfArtist) in
            self.artistResult.removeAll()
            self.albums.removeAll()
            guard let fistArtist = resultOfArtist.first else {
                self.resultsTableView.reloadData()
                return
            }
            Album.getArtistAlbum(artistId:fistArtist.id, successCallback: { (albums) in
                self.artistResult   = resultOfArtist
                self.albums         = albums
                self.resultsTableView.reloadData()
                SVProgressHUD.dismiss()
            }, errorCallback: { (error) in
                SVProgressHUD.showInfo(withStatus: error.localizedDescription)
            })
        }, errorCallback: { error in
            SVProgressHUD.showInfo(withStatus: error.localizedDescription)
        })
    }
    
}


//MARK: TableView Delegate
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if artistResult.count == 0 {
            return 1
        }else {
            return 2
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if artistResult.count == 0 {
            return 1
        }else {
            if section == 1 {
                return albums.count
            }else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if artistResult.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as! EmptyTableViewCell
            cell.configureEmptyCellForArtist()
            return cell
        }else {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistTableViewCell", for: indexPath) as! ArtistTableViewCell
                cell.setupCell(artist: artistResult.first)
                return cell
            }else {
                let currentAlbum = albums[indexPath.row]
                let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as! AlbumTableViewCell
                cell.configureAlbum(album: currentAlbum)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if artistResult.count == 0 { return nil }
        if section == 0 {
            return "Artist"
        }else {
            return "Albums"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let currentAlbum = albums[indexPath.row]
            guard let albumLink = URL(string:currentAlbum.link) else {
                return
            }
            presentSafariViewController(url:albumLink)
        }
    }
    
    func presentSafariViewController(url:URL) {
        let controller = SFSafariViewController(url: url)
        self.present(controller, animated: true, completion: nil)
        controller.delegate = self
    }
}

//MARK: scroll delegate
extension ViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

//MARK: SearchBar Delegate
extension ViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
         searchBar.showsCancelButton = false
         searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 3 {
            guard let query = searchBar.text else {
                SVProgressHUD.showInfo(withStatus: "Please enter a value before searching an artist")
                return
            }
            searchByQuery(query: query)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton  = false
        guard let query = searchBar.text else {
            SVProgressHUD.showInfo(withStatus: "Please enter a value before searching an artist")
            return
        }
        searchByQuery(query: query)
    }
}

//MARK: SafariView Controller Delegate
extension ViewController:SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
