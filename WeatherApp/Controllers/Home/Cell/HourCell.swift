//
//  HourCell.swift
//  WeatherApp
//
//  Created by Kerem Ersu on 29.04.2023.
//

import UIKit

class HourCell: UICollectionViewCell {

    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var hourLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(model: HourCellModel) {
        
        conditionLabel.text = model.condition
        let hourString = model.hour.split(separator: " ")
        hourLabel.text = String(describing:hourString[1])
        weatherImage.image = model.imageCode.getImageFromCode(isDay: model.isDay)
    }
    
    override func layoutSubviews() {
        let leftBorder = CALayer()
        leftBorder.frame = CGRect(x: 0, y: 0, width: 2, height: self.frame.size.height)
        leftBorder.backgroundColor = UIColor.black.cgColor
        self.layer.addSublayer(leftBorder)

        let rightBorder = CALayer()
        rightBorder.frame = CGRect(x: self.frame.size.width - 2, y: 0, width: 4, height: self.frame.size.height)
        rightBorder.backgroundColor = UIColor.black.cgColor
        self.layer.addSublayer(rightBorder)

        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 2)
        topBorder.backgroundColor = UIColor.black.cgColor
        self.layer.addSublayer(topBorder)

        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: self.frame.size.height - 4, width: self.frame.size.width, height: 4)
        bottomBorder.backgroundColor = UIColor.black.cgColor
        self.layer.addSublayer(bottomBorder)
    }
    
    override func prepareForReuse() {
        self.backgroundColor = .white
    }
}
