//
//  SplashViewController.swift
//  WeatherApp
//
//  Created by Kerem Ersu on 1.05.2023.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    @IBOutlet weak var animationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView!.contentMode = .scaleToFill
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 1
        animationView!.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.VCIdentifiers.tabBarVC.rawValue) as! CustomTabBarViewController
            self.dismiss(animated: true) {
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
}
