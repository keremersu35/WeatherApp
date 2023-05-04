//
//  Endpoints.swift
//  WeatherApp
//
//  Created by Kerem Ersu on 1.05.2023.
//

import Foundation

enum Endpoints{
    case forecast
    case search
}

extension Endpoints {
    var rawValue: String {
        get {
            switch (self){
            case .forecast :
                return "/forecast.json"
            case .search :
                return "/search.json"
            }
        }
    }
}
