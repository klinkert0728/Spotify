//
//  SpotifyEndPoint.swift
//  Spotify
//
//  Created by Daniel Klinkert Houfer on 4/26/18.
//  Copyright © 2018 Daniel Klinkert Houfer. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

protocol SpotifyApiEndPoint {
    var baseUrl:URL { get }
    var path: String { get }
    var method:HTTPMethod { get }
    var parameters:[String:Any]? { get }
    var parameterEncoding: ParameterEncoding { get }
    var customHeaders: [String:String]? { get }
}

extension SpotifyApiEndPoint {
    var url:URL {
        return baseUrl.appendingPathComponent(path)
    }
}

enum SpotifyEndPoint {
    case login(email:String,password:String)
    case searchArtist(query:String)
    case searchArtistAlbum(artistId:String)
   
}


extension SpotifyEndPoint:SpotifyApiEndPoint {
    
    var baseUrl:URL {
        switch  self {
        default:
            return URL(string: "https://api.spotify.com/v1/")!
        }
    }
    
    var path:String {
        switch self {
        case .login(email: _, password: _):
            return "session"
        case .searchArtist(query: _):
            return "search"
        case .searchArtistAlbum(artistId: let id):
            return "artists/\(id)/albums"
        }
        
    }
    
    var method: HTTPMethod {
        
        switch self {
        default:
            return .get
        }
    }
    
    var parameters:[String:Any]? {
        
        switch self {
        case .login(email: let email, password: let password):
            return ["email":email,"password":password]
        case .searchArtist(query: let query):
            return ["q":query,"type":"artist"]
        default:
            return [:]
        }
    }
    
    var customHeaders:[String:String]? {
        switch self {
        default:
            return  ["Authorization": "Bearer BQBUmmwKl_S-U2w1VaUNI96Z3_OqJ7BUPWxuxVaWp3AXWdnQdL0t6UoSuOp_qgAmmz9TUJa2V7pwVynshJxnMOJnR7gxNZF7ZPV5VJeoVFLgQ441MvbCLSrvX7LT5ri-WQDHs8nPkc2YL__p","Content-Type":"application/json"]
        }
    }
    
    var parameterEncoding:ParameterEncoding {
        
        switch self {
        case .searchArtist(query: _),.searchArtistAlbum(artistId: _):
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }

    }
}
