//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Kerem Ersu on 30.04.2023.
//

import UIKit
import CoreLocation

class DetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var dayList: [Forecastday2]?
    var cityName = "İzmir, Turkey"
    let networkManager = NetworkManager()
    let locationManager = CLLocationManager()
    var location: String = "izmir"
    
    override func viewWillAppear(_ animated: Bool) {
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        networkManager.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Constants.NibNames.dayCell.rawValue, bundle: nil),
                                forCellWithReuseIdentifier: Constants.NibNames.dayCell.rawValue)
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dayList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.NibNames.dayCell.rawValue, for: indexPath) as! DayCell
        let cellModel = DayCellModel(date: dayList![indexPath.row].date, imageCode: dayList![indexPath.row].day.condition.code, temp: dayList![indexPath.row].day.avgtemp_c, wind: dayList![indexPath.row].day.maxwind_kph, humidity: dayList![indexPath.row].day.avghumidity, city: cityName)
        cell.setup(model: cellModel)
        return cell
    }
}

extension DetailViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
        networkManager.getWeeklyWeather(self.location)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        networkManager.getWeeklyWeather(self.location)
    }
}

extension DetailViewController: WeatherManagerDelegate {
    
    func didUpdateWeeklyWeather(_ networkManager: NetworkManager, model: WeaklyWeatherModel) {
        DispatchQueue.main.async { [self] in
            dayList = model.forecast.forecastday
            cityName = "\(model.location.name), \(model.location.country)"
            collectionView.reloadData()
        }
    }

    func didUpdateWeather(_ weatherManager: NetworkManager, model: CurrentWeatherModel) {}
    func didUpdateForSearch(_ networkManager: NetworkManager, model: [SearchResultModel]) {}
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
