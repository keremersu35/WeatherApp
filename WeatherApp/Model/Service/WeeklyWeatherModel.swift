//
//  WeeklyWeatherModel.swift
//  WeatherApp
//
//  Created by Kerem Ersu on 1.05.2023.
//

import Foundation

struct WeaklyWeatherModel: Codable {
    
    let location: Location
    let current: Current
    let forecast: Forecast2
}

struct Forecastday2: Codable {
    let date: String
    let date_epoch: Int
    let day: Day
    let astro: Astro
}

struct Forecast2: Codable {
    let forecastday: [Forecastday2]
}
