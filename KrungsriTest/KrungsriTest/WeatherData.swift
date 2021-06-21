//
//  WeatherData.swift
//  KrungsriTest
//
//  Created by somsak on 11/6/2564 BE.
//

struct WeatherData: Codable {
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
}

struct Weather: Codable {
    let id: Int
}

struct ForecastData: Codable {
    let dt_txt: String
    let main: Main
    let weather: [Weather]
}
