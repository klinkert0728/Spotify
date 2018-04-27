//
//  Artist.swift
//  Spotify
//
//  Created by Daniel Klinkert Houfer on 4/26/18.
//  Copyright © 2018 Daniel Klinkert Houfer. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import ObjectMapper

class Artist: Object, Mappable {
    dynamic var id                  = ""
    dynamic var name                = ""
    dynamic var popularity          = 0
    dynamic var numberOfFollowers   = 0
    dynamic var artistImageUrl      = ""
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name                    <- map["name"]
        numberOfFollowers       <- map["followers.total"]
        artistImageUrl          <- map["images.0.url"]
        popularity              <- map["popularity"]
        id                      <- map["id"]
    }
    
    
    class func getArtist(query:String,successCallback:@escaping (_ artist:[Artist])->(),errorCallback:@escaping (_ error:Error)->())  {
        SpotifyClient.sharedClient.requestArrayOfObject(endpoint: SpotifyEndPoint.searchArtist(query: query), keyPath: "artists.items", completionHandler: { (artist:[Artist]) in
            successCallback(artist)
        }, errorClosure: {error in
            errorCallback(error)
        })
    }
}
