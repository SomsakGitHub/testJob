//
//  ViewController.swift
//  KrungsriTest
//
//  Created by somsak on 11/6/2564 BE.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    private var viewModel: ViewModel!
    
    private var forecastData: [ForecastData?] = []
    private var celsius = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = ViewModel(view: self)
    }
    
    @IBAction func forecastViewTouch(_ sender: Any) {
        self.performSegue(withIdentifier: "goToForecast", sender: self)
    }
    
    @IBAction func searchTouch(_ sender: Any) {
        if self.searchTextField.text != ""{
            self.viewModel.fetchData(city: self.searchTextField.text ?? "")
        }
    }
    
    @IBAction func temperatureConvertTouch(_ sender: Any) {
        let fahrenheit = (29 * 9.0) / 5.0 + 32.0
        self.temperatureLabel.text = "\(fahrenheit) F."
    }
    
    //MARK: Pass data with segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let forecastViewController = segue.destination as? ForecastViewController {
            forecastViewController.forecastData = self.forecastData
        }
    }
    
    private func getCurrentWeatherString(id: Int) -> String{
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}

//MARK: ViewModelDelegate.
extension ViewController: ViewModelDelegate {
    func didFinishFetchData(weather: WeatherData?, forecast: [ForecastData?]) {
        self.forecastData = forecast
        if weather != nil {
            let imageName = getCurrentWeatherString(id: weather?.weather.first!.id ?? 0)
            self.currentWeatherImage.image = UIImage(systemName: imageName)
            self.celsius = (weather?.main.temp ?? 0.0) - 273.15
            self.temperatureLabel.text = String(format: "%.0f", celsius) + " C."
            self.humidityLabel.text = String(weather?.main.humidity ?? 0)
        }
    }
}
