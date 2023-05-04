//
//  RootStackViewViewController.swift
//  WeatherApp
//
//  Created by Kerem Ersu on 30.04.2023.
//

import UIKit

class RootStackTabViewController: UIViewController {

    @IBOutlet weak var bottomStack: UIStackView!
    
    var currentIndex = 0
    
    lazy var tabs: [StackItemView] = {
        var items = [StackItemView]()
        for _ in 0..<5 {
            items.append(StackItemView.newInstance)
        }
        return items
    }()
    
    lazy var tabModels: [BottomStackItem] = {
        return [
            BottomStackItem(title: "Home", image: "house"),
            BottomStackItem(title: "Search", image: "search"),
            BottomStackItem(title: "detail", image: "detail"),
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
    }

    func setupTabs() {
        for (index, var model) in self.tabModels.enumerated() {
            let tabView = self.tabs[index]
            model.isSelected = index == 0
            tabView.item = model
            tabView.delegate = self
            self.bottomStack.addArrangedSubview(tabView)
        }
    }
    
    
}

extension RootStackTabViewController: StackItemViewDelegate {
    
    func handleTap(_ view: StackItemView) {
        self.tabs[self.currentIndex].isSelected = false
        view.isSelected = true
        self.currentIndex = self.tabs.firstIndex(where: { $0 === view }) ?? 0
    }
    
}
