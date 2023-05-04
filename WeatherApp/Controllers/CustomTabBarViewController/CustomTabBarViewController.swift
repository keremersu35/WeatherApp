//
//  CustomTabBarViewController.swift
//  WeatherApp
//
//  Created by Kerem Ersu on 30.04.2023.
//

import UIKit

class CustomTabBarViewController: UIViewController {

    @IBOutlet weak var bottomStack: UIStackView!
    @IBOutlet weak var containerView: UIView!
    var main: UIStoryboard { return UIStoryboard(name: "Main", bundle: nil)}
    
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
            BottomStackItem(title: Constants.TabTitles.home.rawValue, image: Constants.ImageNames.home.rawValue),
            BottomStackItem(title: Constants.TabTitles.search.rawValue, image: Constants.ImageNames.search.rawValue),
            BottomStackItem(title: Constants.TabTitles.detail.rawValue, image: Constants.ImageNames.detail.rawValue),
        ]
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        let controller = main.instantiateViewController(withIdentifier: Constants.VCIdentifiers.homeVC.rawValue)
        addChild(controller)
        containerView?.addSubview(controller.view)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.topAnchor.constraint(equalTo: containerView!.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: containerView!.bottomAnchor).isActive = true
        controller.view.leadingAnchor.constraint(equalTo: containerView!.leadingAnchor).isActive = true
        controller.view.trailingAnchor.constraint(equalTo: containerView!.trailingAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTabs()
        bottomStack.customize(backgroundColor: UIColor(named: Constants.ColorNames.primary.rawValue)!, radiusSize: 12)
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

extension CustomTabBarViewController: StackItemViewDelegate {
    
    func handleTap(_ view: StackItemView) {
        self.tabs[self.currentIndex].isSelected = false
        view.isSelected = true
        
        self.currentIndex = self.tabs.firstIndex(where: { $0 === view }) ?? 0
        
        if self.currentIndex == 0 {
            let controller = main.instantiateViewController(withIdentifier: Constants.VCIdentifiers.homeVC.rawValue)
            addChild(controller)
            containerView?.addSubview(controller.view)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            controller.view.topAnchor.constraint(equalTo: containerView!.topAnchor).isActive = true
            controller.view.bottomAnchor.constraint(equalTo: containerView!.bottomAnchor).isActive = true
            controller.view.leadingAnchor.constraint(equalTo: containerView!.leadingAnchor).isActive = true
            controller.view.trailingAnchor.constraint(equalTo: containerView!.trailingAnchor).isActive = true
        }
        else if self.currentIndex == 1 {
            let controller = main.instantiateViewController(withIdentifier: Constants.VCIdentifiers.searchVC.rawValue)
            addChild(controller)
            containerView?.addSubview(controller.view)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            controller.view.topAnchor.constraint(equalTo: containerView!.topAnchor).isActive = true
            controller.view.bottomAnchor.constraint(equalTo: containerView!.bottomAnchor).isActive = true
            controller.view.leadingAnchor.constraint(equalTo: containerView!.leadingAnchor).isActive = true
            controller.view.trailingAnchor.constraint(equalTo: containerView!.trailingAnchor).isActive = true
        }
        
        else if self.currentIndex == 2 {
            let controller = main.instantiateViewController(withIdentifier: Constants.VCIdentifiers.detailVC.rawValue)
            addChild(controller)
            containerView?.addSubview(controller.view)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            controller.view.topAnchor.constraint(equalTo: containerView!.topAnchor).isActive = true
            controller.view.bottomAnchor.constraint(equalTo: containerView!.bottomAnchor).isActive = true
            controller.view.leadingAnchor.constraint(equalTo: containerView!.leadingAnchor).isActive = true
            controller.view.trailingAnchor.constraint(equalTo: containerView!.trailingAnchor).isActive = true
        }
    }
}

