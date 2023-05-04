//
//  Constants.swift
//  WeatherApp
//
//  Created by Kerem Ersu on 30.04.2023.
//

import Foundation

struct Constants {
    
    enum NibNames: String {
        
        case hourCell = "HourCell"
        case dayCell = "DayCell"
        case searchCell = "SearchCell"
    }
    
    enum ImageNames: String {
        
        case home = "home"
        case search = "search"
        case detail = "detail"
        case magnifyingglass = "magnifyingglass"
    }
    
    enum TabTitles: String {
        
        case home = "Home"
        case search = "Search"
        case detail = "Detail"
    }
    
    enum ColorNames: String {
        
        case primary = "Primary"
        case secondary = "Secondary"
    }
    
    enum VCIdentifiers: String {
        
        case homeVC = "HomeVC"
        case tabBarVC = "TabBarVC"
        case searchVC = "SearchVC"
        case detailVC = "DetailVC"
        case searchDetailVC = "SearchDetailVC"
        case splashVC = "SplashVC"
    }
}
