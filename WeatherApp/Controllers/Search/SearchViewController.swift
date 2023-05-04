//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Kerem Ersu on 30.04.2023.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    var results = [SearchResultModel]()
    var latestSearchText = ""
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        searchTextField.delegate = self
        searchTextField.addLeadingIcon(Constants.ImageNames.magnifyingglass.rawValue)
        tableView.register(UINib(nibName: Constants.NibNames.searchCell.rawValue, bundle: nil), forCellReuseIdentifier: Constants.NibNames.searchCell.rawValue)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NibNames.searchCell.rawValue, for: indexPath) as! SearchCell
        cell.setup("\(results[indexPath.row].name), \(results[indexPath.row].country)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myNewViewController = storyboard?.instantiateViewController(withIdentifier: Constants.VCIdentifiers.searchDetailVC.rawValue) as! SearchDetailViewController
        myNewViewController.location = results[indexPath.row].name
        present(myNewViewController, animated: true, completion: nil)
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")
        let typedCharacterSet = CharacterSet(charactersIn: string)
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if updatedText.count >= 3 {
            latestSearchText = updatedText
            networkManager.getSearchResults(latestSearchText.replacingOccurrences(of: " ", with: ""))
        }else {
            results.removeAll()
            tableView.reloadData()
        }
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }
}

extension SearchViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ networkManager: NetworkManager, model: CurrentWeatherModel) {}
    func didUpdateWeeklyWeather(_ networkManager: NetworkManager, model: WeaklyWeatherModel) {}
    
    func didUpdateForSearch(_ networkManager: NetworkManager, model: [SearchResultModel]) {
        results = model
        tableView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}
