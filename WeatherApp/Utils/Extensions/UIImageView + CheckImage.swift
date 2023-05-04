//
//  UIImageView + CheckImage.swift
//  WeatherApp
//
//  Created by Kerem Ersu on 30.04.2023.
//

import UIKit

extension Int {
    func getImageFromCode(isDay: Bool) -> UIImage{
        
        if (self == 1000 && isDay){
            return UIImage(named: "sun")!
        }
        else if (self == 1000 && !isDay){
            return UIImage(named: "moon")!
        }
        else if (self == 1003 && isDay){
            return UIImage(named: "cloudySun")!
        }
        else if (self == 1003 && !isDay){
            return UIImage(named: "cloudyMoon")!
        }
        else if (self == 1006){
            return UIImage(named: "cloudy")!
        }
        else if (self == 1009){
            return UIImage(named: "cloudy")!
        }
        else if (self == 1063){
            return UIImage(named: "rainy")!
        }
        else if (self == 1069){
            return UIImage(named: "rainy")!
        }
        else if (self == 1183){
            return UIImage(named: "rainy")!
        }
        else if (self == 1192){
            return UIImage(named: "rainy")!
        }
        else if (self == 1189){
            return UIImage(named: "rainy")!
        }
        else if (self == 1195){
            return UIImage(named: "rainy")!
        }
        else if (self == 1198){
            return UIImage(named: "rainy")!
        }
        else if (self == 1201){
            return UIImage(named: "rainy")!
        }
        else if (self == 1204){
            return UIImage(named: "rainy")!
        }
        else if (self == 1240){
            return UIImage(named: "rainy")!
        }
        else if (self == 1243){
            return UIImage(named: "rainy")!
        }
        else if (self == 1246){
            return UIImage(named: "rainy")!
        }
        else {
            return UIImage(named: "snowy")!
        }
    }
}
