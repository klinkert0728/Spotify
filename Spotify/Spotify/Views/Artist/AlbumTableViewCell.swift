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
        albumName.text  = "Name: " + album.name
       
        if album.availableCountriesArray.count > 5 {
            availableIn.text =  "Available in : " + album.availableCountriesArray.joined(separator: ",")
        }else {
            availableIn.isHidden = true
        }
        guard let url = URL(string:album.albumImageUrl) else {
            return
        }
        albumImage.layer.shadowColor    = UIColor.black.cgColor
        albumImage.layer.shadowOpacity  = 0.5
        albumImage.layer.shadowOffset   = CGSize.zero
        albumImage.layer.shadowRadius   = 35
        albumImage.af_setImage(withURL:url)
    }
}
