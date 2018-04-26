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
    case search(query:String)
   
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
        default:
            return "json"
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
        default:
            return [:]
        }
    }
    
    var customHeaders:[String:String]? {
        switch self {
        default:
            return  ["Authorization": "Bearer BQDo3BU4Cxr7ODfA3r3Z22psZtjKTCf4tdOIZVtnx1nghrj3tls6-tZHoWL2Ars3UeO4_F7myeVALMvg63pJKGgEf3Mxh13zx6iAUYe-HUJcxDdVRNZ8KTDDOU-zfn50lX7kpHgf5UX_QBzK","Content-Type":"application/json"]
        }
    }
    
    var parameterEncoding:ParameterEncoding {
        
        switch self {
        default:
            return JSONEncoding.default
        }

    }
}
