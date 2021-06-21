//
//  ViewModel.swift
//  KrungsriTest
//
//  Created by somsak on 11/6/2564 BE.
//

import Alamofire
import SwiftyJSON

//MARK: ViewModelDelegate.
protocol ViewModelDelegate {
    func didFinishFetchData(weather: WeatherData?, forecast: [ForecastData?])
}

//MARK: ViewModel.
class ViewModel{
    
    init(view: ViewModelDelegate) {
        self.viewModelDelegate = view
    }
    
    private let service = ServiceWrapper()
    private let dispatchGroup = DispatchGroup()
    private let decoder = JSONDecoder()
    private let viewModelDelegate: ViewModelDelegate?
    private var weatherData: WeatherData? = nil
    private var forecastData: [ForecastData?] = []
    private let baseURL = "https://api.openweathermap.org/data/2.5"
    private let apiKey = "7ee7189a256bfcdd0ccef95460f07b77"
    
    func fetchData(city: String){
        dispatchGroup.enter()
        fetchWeather(city: city)
        dispatchGroup.enter()
        fetchForecast(city: city)
    }
    
    private func fetchWeather(city: String){
        
        var urlRequest = URLRequest(url:  URL(string:  "\(baseURL)/weather?q=\(city)&appid=\(apiKey)")!)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.timeoutInterval = 10 // secs
        
        service.serviceResponse(request: urlRequest) { [self] (response, status) in
            
            switch status {
                case .success:
                    let json: JSON = JSON(response as Any)
                    
                    DispatchQueue.main.async {
                        do {
                            let data = try json.rawData()
                            self.weatherData = try self.decoder.decode(WeatherData.self, from: data)
                        } catch {
                            print(error.localizedDescription)
                        }
                        self.dispatchGroup.leave()
                    }
                default :
                    break
            }
        }
    }
    
    private func fetchForecast(city: String){
        
        var urlRequest = URLRequest(url:  URL(string:  "\(baseURL)/forecast?q=\(city)&appid=\(apiKey)")!)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.timeoutInterval = 10 // secs
        
        service.serviceResponse(request: urlRequest) { (response, status) in
            
            switch status {
                case .success:
                    let json: JSON = JSON(response as Any)
                    
                    DispatchQueue.main.async {
                        do {
                            let data = try json["list"].rawData()
                            self.forecastData = try self.decoder.decode([ForecastData].self, from: data)
                            self.viewModelDelegate!.didFinishFetchData(weather: self.weatherData, forecast: self.forecastData)
                        } catch {
                            print(error.localizedDescription)
                        }
                        self.dispatchGroup.leave()
                    }
                default :
                    self.viewModelDelegate!.didFinishFetchData(weather: self.weatherData, forecast: self.forecastData)
                    break
            }
        }
    }
}


