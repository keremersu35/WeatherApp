//
//  BottomStackItem.swift
//  WeatherApp
//
//  Created by Kerem Ersu on 30.04.2023.
//

import Foundation

struct BottomStackItem {
    
    var title: String
    var image: String
    var isSelected: Bool
    
    init(title: String,
         image: String,
         isSelected: Bool = false) {
        self.title = title
        self.image = image
        self.isSelected = isSelected
    }
}
