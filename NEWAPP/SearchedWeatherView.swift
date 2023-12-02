//
//  SearchedWeatherView.swift
//  NEWAPP
//
//  Created by Memory Mhou on 02/12/2023.
//

import Foundation
import SwiftUI
import CoreLocation

struct SearchedWeatherView: View {
    var weather: Weather
    var searchedCityName: String

    var body: some View {
        VStack {
            Text("Weather in \(searchedCityName)")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 10)

            TopHalfView(weather: weather, cityName: "")
                .padding(.bottom, 20)

            BottomHalfView(weather: weather, weeklyForecast: [])
                .padding(.bottom, 20)
        }
        .background(weather.conditionBackground)
        .foregroundColor(.white)
        .cornerRadius(20)
        .padding()
    }
}

