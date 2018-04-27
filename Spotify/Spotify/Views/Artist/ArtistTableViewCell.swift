//
//  ArtistTableViewCell.swift
//  Spotify
//
//  Created by Daniel Klinkert Houfer on 4/26/18.
//  Copyright © 2018 Daniel Klinkert Houfer. All rights reserved.
//

import UIKit
import AlamofireImage

class ArtistTableViewCell: UITableViewCell {

    
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var numberOfFollowers: UILabel!
    @IBOutlet weak var firstStar: UIImageView!
    @IBOutlet weak var secondStar: UIImageView!
    @IBOutlet weak var thirdStar: UIImageView!
    @IBOutlet weak var fourthStar: UIImageView!
    @IBOutlet weak var fivethStar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(artist:Artist?) {
        guard let artist = artist else {
            return
        }
        artistName.text = artist.name
       
        numberOfFollowers.text      = "Number of Followers: \(artist.numberOfFollowers.formatInt() ?? "")"
        artistImage.af_setImage(withURL: URL(string:artist.artistImageUrl)!)
        calculateStarRank(popularity: artist.popularity)
    }
    
    
    fileprivate func calculateStarRank(popularity:Int) {
        switch popularity {
        case 0 ... 20:
            fivethStar.isHidden = true
            fourthStar.isHidden = true
            thirdStar.isHidden  = true
            secondStar.isHidden = true
            firstStar.isHidden  = false
        case 20 ... 40:
            fivethStar.isHidden = true
            fourthStar.isHidden = true
            thirdStar.isHidden  = true
            secondStar.isHidden = false
            firstStar.isHidden  = false
            break
        case 40 ... 60:
            fivethStar.isHidden = true
            fourthStar.isHidden = true
            thirdStar.isHidden  = false
            secondStar.isHidden = false
            firstStar.isHidden  = false
            break
        case 60 ... 80:
            fivethStar.isHidden = true
            fourthStar.isHidden = false
            thirdStar.isHidden  = false
            secondStar.isHidden = false
            firstStar.isHidden  = false
        
            break
        case 80 ... 100:
            fivethStar.isHidden = false
            fourthStar.isHidden = false
            thirdStar.isHidden  = false
            secondStar.isHidden = false
            firstStar.isHidden  = false
        default:
            break
        }
    }
    
}
