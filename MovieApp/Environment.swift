//
//  Environment.swift
//  MovieApp
//
//  Created by atit on 23/09/2022.
//

import Foundation

enum Environment: String {
    
    case backendUrl = "Backend_Url"
    case apiKey = "ApiKey"
    
    static func getBaseUrl(key: Environment) -> String {
        guard let dict = Bundle(for: AppDelegate.self).infoDictionary,
              let urlString = dict[key.rawValue] as? String else { fatalError("URL not found in framework info.plist")
        }
        return urlString
    }
}

