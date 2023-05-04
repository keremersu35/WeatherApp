//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Kerem Ersu on 29.04.2023.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ networkManager: NetworkManager, model: CurrentWeatherModel)
    func didUpdateWeeklyWeather(_ networkManager: NetworkManager, model: WeaklyWeatherModel)
    func didUpdateForSearch(_ networkManager: NetworkManager, model: [SearchResultModel])
    func didFailWithError(error: Error)
}

class NetworkManager {
    
    var delegate: WeatherManagerDelegate?
 
    enum ManagerErrors: Error {
        case invalidResponse
        case invalidStatusCode(Int)
    }
    
    private let baseURL: String = "https://api.weatherapi.com/v1";
    
    func request<T: Decodable>(path : Endpoints, httpMethod: HttpMethods = .get, params : String?, token : String?, httpBody: Codable?,completion: @escaping (Result<T, Error>) -> Void) {
         
         let completionOnMain: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }

        guard let url = URL(string: "\(baseURL)\(path.rawValue)\(params ?? "")") else { fatalError("Invalid URL") }
        var request = URLRequest(url: url)
        
        if token != nil && token != ""{
            request.setValue("Authorization", forHTTPHeaderField: token!);
        }
        
        request.httpMethod = httpMethod.rawValue
        
      
        do {
            if httpBody != nil {
                let rawHttpBody = try JSONEncoder().encode(httpBody!.self)
                request.httpBody = rawHttpBody;
            }
        }catch{
            print("JSON ENCODE FAILED");
        }
        
        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
           
            if let error = error {
                completionOnMain(.failure(error))
                return
            }

            guard let urlResponse = response as? HTTPURLResponse else { return completionOnMain(.failure(ManagerErrors.invalidResponse)) }
            if !(200..<300).contains(urlResponse.statusCode) {
                return completionOnMain(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
            }
            
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                
                completionOnMain(.success(response))
            } catch {
                debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
                completionOnMain(.failure(error))
            }
        }
        urlSession.resume()
    }
    
    func getWeather(_ location: String){
        request(path: .forecast, params: "?key=e7499fce4c014e7d81051834232904&q=\(location)&day=1&aqi=no&alerts=no", token: nil, httpBody: nil
        ) { (result: Result<CurrentWeatherModel, Error>) in
            switch result {
            case .success(let response):
                self.delegate?.didUpdateWeather(self, model: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getWeeklyWeather(_ location: String){
        request(path: .forecast, params: "?key=e7499fce4c014e7d81051834232904&q=\(location)&days=7&aqi=no&alerts=no", token: nil, httpBody: nil
        ) { (result: Result<WeaklyWeatherModel, Error>) in
            switch result {
            case .success(let response):
                self.delegate?.didUpdateWeeklyWeather(self, model: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getSearchResults(_ query: String){
        request(path: .search, params: "?key=e7499fce4c014e7d81051834232904&q=\(query)", token: nil, httpBody: nil
        ) { (result: Result<[SearchResultModel], Error>) in
            switch result {
            case .success(let response):
                self.delegate?.didUpdateForSearch(self, model: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
