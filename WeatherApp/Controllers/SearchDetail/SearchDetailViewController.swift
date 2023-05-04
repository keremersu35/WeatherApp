//
//  SearchDetailViewController.swift
//  WeatherApp
//
//  Created by Kerem Ersu on 1.05.2023.
//

import UIKit

class SearchDetailViewController: UIViewController {

    let networkManager = NetworkManager()
    var hourList: [Hour]? = nil
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    var location: String = "izmir"
    var selectedIndex = 0
    var indexPath: IndexPath?

    override func viewWillAppear(_ animated: Bool) {
    
        networkManager.delegate = self
        networkManager.getWeather(location)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Constants.NibNames.hourCell.rawValue, bundle: nil),
                                forCellWithReuseIdentifier: Constants.NibNames.hourCell.rawValue)
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension SearchDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.NibNames.hourCell.rawValue, for: indexPath) as! HourCell
        let isDayy = hourList![indexPath.row].isDay == 1
        cell.backgroundColor = selectedIndex == indexPath.row ? UIColor(named: Constants.ColorNames.primary.rawValue) : .white
        
        let hourCellModel = HourCellModel(hour: hourList![indexPath.row].time, imageCode: hourList![indexPath.row].condition.code, condition: (hourList![indexPath.row].condition.text), isDay: isDayy)
        
        cell.setup(model: hourCellModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        collectionView.reloadData()
    }
}

extension SearchDetailViewController: WeatherManagerDelegate {
    func didUpdateForSearch(_ networkManager: NetworkManager, model: [SearchResultModel]) {}
    func didUpdateWeeklyWeather(_ networkManager: NetworkManager, model: WeaklyWeatherModel) {}
    
    func didUpdateWeather(_ weatherManager: NetworkManager, model: CurrentWeatherModel) {
        DispatchQueue.main.async { [self] in
            
            self.hourList = model.forecast.forecastday[0].hour
            let isDay = model.current.is_day == 1
            self.weatherImage.image = model.current.condition.code.getImageFromCode(isDay: isDay)
            cityLabel.text = "\(String(describing: model.location.name)), \(String(describing: model.location.country))"
            tempLabel.text = String(describing: model.current.temp_c)
            windLabel.text = String(describing: model.current.wind_kph)
            humidityLabel.text = "\(String(describing: model.current.humidity))%"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = model.location.localtime.split(separator: " ")
            if let date = dateFormatter.date(from: String(dateString[0])) {
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let formattedDateString = dateFormatter.string(from: date)
                dateLabel.text = formattedDateString
            }
            
            let dateString2 = model.location.localtime
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            if let date = dateFormatter.date(from: dateString2) {
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                let formattedHour = String(format: "%02d", hour)
                self.indexPath = IndexPath(row: Int(formattedHour)! , section: 0)
            }

            collectionView.reloadData()
            selectedIndex = self.indexPath?.row ?? 0
            collectionView.scrollToItem(at: self.indexPath ?? IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
