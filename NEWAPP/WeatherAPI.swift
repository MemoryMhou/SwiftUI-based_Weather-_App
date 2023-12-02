//
//  WeatherAPI.swift
//  NEWAPP
//
//  Created by Memory Mhou on 02/12/2023.
//

import Foundation
import SwiftUI
import CoreLocation

struct WeatherAPI {
    let apiKey = "eacc9847289eb6d43c68b816c964a529"

    func getWeatherData(city: String, completion: @escaping (Weather?) -> Void) {
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCity)&units=metric&appid=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                let weather = Weather(
                    temperature: weatherData.main.temp,
                    minTemperature: weatherData.main.temp_min,
                    maxTemperature: weatherData.main.temp_max,
                    condition: weatherData.weather.first?.description ?? "",
                    conditionIcon: weatherData.weather.first?.icon ?? "",
                    conditionBackgroundURL: URL(string: "https://source.unsplash.com/1600x900/?\(weatherData.weather.first?.description ?? "")"),
                    conditionBackground: background(for: weatherData.weather.first?.description ?? ""),
                    dayOfWeek: ""
                )
                completion(weather)
            } catch {
                completion(nil)
            }
        }.resume()
    }
    

    func getWeeklyForecast(city: String, completion: @escaping ([Weather]) -> Void) {
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(encodedCity)&units=metric&appid=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }

            do {
                let forecastData = try JSONDecoder().decode(WeeklyForecastData.self, from: data)
                var dailyForecastDict: [String: Weather] = [:]

                for forecast in forecastData.list {
                    let dayOfWeek = self.getDayOfWeek(from: forecast.dt_txt)
                    guard let maxTemp = dailyForecastDict[dayOfWeek]?.maxTemperature else {
                       
                        let weather = Weather(
                            temperature: forecast.main.temp,
                            minTemperature: forecast.main.temp_min,
                            maxTemperature: forecast.main.temp_max,
                            condition: forecast.weather.first?.description ?? "",
                            conditionIcon: forecast.weather.first?.icon ?? "",
                            conditionBackgroundURL: nil,
                            conditionBackground: self.background(for: forecast.weather.first?.description ?? ""),
                            dayOfWeek: dayOfWeek
                        )
                        dailyForecastDict[dayOfWeek] = weather
                        continue
                    }

                    
                    if forecast.main.temp_max > maxTemp {
                        dailyForecastDict[dayOfWeek]?.maxTemperature = forecast.main.temp_max
                    }
                }

                let uniqueWeeklyForecast = Array(dailyForecastDict.values)
                completion(uniqueWeeklyForecast)
            } catch {
                completion([])
            }
        }.resume()
    }

    private func background(for condition: String) -> Color {
        switch condition.lowercased() {
        case "clear":
            return Color.blue
        case "clouds":
            return Color.gray
        case "rain":
            return Color.blue
        default:
            return Color.blue
        }
    }

    private func getDayOfWeek(from dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "EEE"

            
            if let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: date) {
                return formatter.string(from: nextDate)
            }
        }
        return ""
    }
}
