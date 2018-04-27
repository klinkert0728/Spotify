//
//  Album.swift
//  Spotify
//
//  Created by Daniel Klinkert Houfer on 4/26/18.
//  Copyright © 2018 Daniel Klinkert Houfer. All rights reserved.
//

import UIKit
import Foundation
import UIKit
import RealmSwift
import ObjectMapper

class Album: Object, Mappable {
    dynamic var id                              = ""
    dynamic var name                            = ""
    dynamic var albumImageUrl                   = ""
    fileprivate var availableCountries          = List<RealmString>()
    dynamic var link                            = ""
    
    var availableCountriesArray:[String] {
        get {
            return availableCountries.map({$0.value})
        }
        
        set {
            availableCountries.removeAll()
            availableCountries.append(objectsIn: newValue.map({RealmString(value:[$0])}))
        }
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    override class func ignoredProperties() -> [String] { return ["availableCountriesArray"] }
    
    func mapping(map: Map) {
        name                    <- map["name"]
        albumImageUrl           <- map["images.0.url"]
        id                      <- map["id"]
        availableCountriesArray <- map["available_markets"]
        link                    <- map["external_urls.spotify"]
    }
    
    class func getArtistAlbum(artistId:String,successCallback:@escaping (_ albums:[Album])->(),errorCallback:@escaping (_ error:Error)->())  {
        SpotifyClient.sharedClient.requestArrayOfObject(endpoint: SpotifyEndPoint.searchArtistAlbum(artistId: artistId), keyPath: "items", completionHandler: { (albums:[Album]) in
            successCallback(albums)
        }, errorClosure: { error in
            errorCallback(error)
        })
    }
}
