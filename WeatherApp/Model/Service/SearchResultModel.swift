//
//  SearchResultModel.swift
//  WeatherApp
//
//  Created by Kerem Ersu on 1.05.2023.
//

import Foundation

struct SearchResultModel: Codable {
    let id: Int
    let name, region, country: String
    let lat, lon: Double
    let url: String
}
