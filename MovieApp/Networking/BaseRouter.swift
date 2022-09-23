//
//  BaseRouter.swift
//  MovieApp
//
//  Created by atit on 21/09/2022.
//

import Foundation

/// The web http request methods
public enum HTTPMethod {
    
    case get, post, put, delete, patch
    
    var identifier: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .put: return "PUT"
        case .delete: return "DELETE"
        case .patch: return "PATCH"
        }
    }
}

protocol Endpoint {
    
    var httpMethod: HTTPMethod { get }
    var baseURLString: String { get }
    var path: String { get }
//    var headers: [String: Any]? { get }
//    var body: [String: Any]? { get }
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
        switch self {
        case .getMovieList:
            return "https://api.themoviedb.org/3/"
        case .getMovieDetail(let id):
            return "https://api.themoviedb.org/3/movie/\(id)"
        }
    }
    
    var path: String {
        switch self {
        case .getMovieList(let pageNo):
            return "discover/movie?api_key=f4824af0a09c59035f4fe92da98da1d6&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(pageNo)&with_watch_monetization_types=flatrate"
        case .getMovieDetail:
            return "?api_key=f4824af0a09c59035f4fe92da98da1d6&language=en-US"
        }
    }
    
//    var headers: [String: Any]? {
//        switch self {
//        case .getMovieList:
//            return [:]
//        case .getMovieDetail:
//
//        }
//    }
    
//    var body: [String : Any]? {
//        switch self {
//        case .getMovieList:
//            return [:]
//        }
//    }
}

