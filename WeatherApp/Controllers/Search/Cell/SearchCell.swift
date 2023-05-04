//
//  SearchCell.swift
//  WeatherApp
//
//  Created by Kerem Ersu on 1.05.2023.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setup(_ city: String) {
        cityLabel.text = city
    }
    
}
