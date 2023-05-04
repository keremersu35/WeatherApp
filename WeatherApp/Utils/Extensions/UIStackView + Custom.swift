//
//  UIStackView + Custom.swift
//  WeatherApp
//
//  Created by Kerem Ersu on 30.04.2023.
//

import UIKit

extension UIStackView {
    func customize(backgroundColor: UIColor = .clear, radiusSize: CGFloat = 0) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = backgroundColor
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)

        subView.layer.cornerRadius = radiusSize
        subView.layer.borderWidth = 1
        subView.layer.masksToBounds = true
        subView.clipsToBounds = true
    }
}
