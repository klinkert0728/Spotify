//
//  EmptyTableViewCell.swift
//  Spotify
//
//  Created by Daniel Klinkert Houfer on 4/26/18.
//  Copyright © 2018 Daniel Klinkert Houfer. All rights reserved.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {

    @IBOutlet weak var emptyCellMessage: UILabel!
    @IBOutlet weak var emptyCellImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureEmptyCellForArtist() {
        emptyCellImage.image    = UIImage(named:"search_artist")
        emptyCellMessage.text   = "Search your favorite artiste above"
    }
    
}
