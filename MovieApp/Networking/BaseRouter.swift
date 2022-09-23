//
//  BaseRouter.swift
//  MovieApp
//
//  Created by atit on 21/09/2022.
//

import Foundation

enum HTTPMethod: String {
    case get
    
    var identifier: String {
        return self.rawValue.uppercased()
    }
}

protocol Endpoint {
    var httpMethod: HTTPMethod { get }
    var baseURLString: String { get }
    var path: String { get }
}

extension Endpoint {
    
    var url: String {
        return baseURLString + path
    }
}

enum BaseRouter: Endpoint {
    
    case getMovieList(Int)
    case getMovieDetail(Int)
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getMovieList, .getMovieDetail:
            return .get
        }
    }
    
    var baseURLString: String {
        return Environment.getBaseUrl(key: .backendUrl)
    }
    
    var path: String {
        switch self {
        case .getMovieList(let pageNo):
            return "discover/movie?api_key=\(Environment.getBaseUrl(key: .apiKey))&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(pageNo)&with_watch_monetization_types=flatrate"
        case .getMovieDetail(let id):
            return "movie/\(id)?api_key=\(Environment.getBaseUrl(key: .apiKey))&language=en-US"
        }
    }
}

