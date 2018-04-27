//
//  AlbumTableViewCell.swift
//  Spotify
//
//  Created by Daniel Klinkert Houfer on 4/26/18.
//  Copyright © 2018 Daniel Klinkert Houfer. All rights reserved.
//

import UIKit
import AlamofireImage

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var availableIn: UILabel!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureAlbum(album:Album) {
        albumName.text  = album.name
        albumImage.af_setImage(withURL: URL(string:album.albumImageUrl)!)
        if album.availableCountriesArray.count > 5 {
            availableIn.text =  "Available in : " + album.availableCountriesArray.joined(separator: ",")
        }else {
            availableIn.isHidden = true
        }
    }
}
