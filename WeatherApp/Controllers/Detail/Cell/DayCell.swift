//
//  DayCell.swift
//  WeatherApp
//
//  Created by Kerem Ersu on 1.05.2023.
//

import UIKit

class DayCell: UICollectionViewCell {

    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(model: DayCellModel) {
        
        tempLabel.text = "\(String(describing: model.temp))°C"
        windLabel.text = "\(String(describing: Int(model.wind))) km/h"
        humidityLabel.text = "\(String(describing: Int(model.humidity)))%"
        cityLabel.text = model.city
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: model.date) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let formattedDate = dateFormatter.string(from: date)
            dateLabel.text = formattedDate
        }
        weatherImage.image = model.imageCode.getImageFromCode(isDay: true)
    }
}
