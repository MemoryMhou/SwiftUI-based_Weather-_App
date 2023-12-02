//
//  SearchView.swift
//  NEWAPP
//
//  Created by Memory Mhou on 26/11/2023.
//

import Foundation
import SwiftUI
import CoreLocation


struct SearchView: View {
    @State private var cityName = ""
    @State private var isSearching = false
    @State private var searchedWeather: Weather?

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter City Name", text: $cityName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    WeatherAPI().getWeatherData(city: cityName) { weather in
                        if let weather = weather {
                            searchedWeather = weather
                            isSearching = false
                        } else {
                           
                        }
                    }
                }) {
                    Text("Search")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                if let searchedWeather = searchedWeather {
                    SearchedWeatherView(weather: searchedWeather, searchedCityName: cityName)
                        .transition(.opacity)
                        .animation(.easeInOut)
                }
            }
            .navigationTitle("Weather Search")
        }
    }
}
