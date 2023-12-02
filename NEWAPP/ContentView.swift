//
//  ContentView.swift
//  NEWAPP
//
//  Created by Memory Mhou on 26/11/2023.
//
import SwiftUI
import CoreLocation

struct ContentView: View {
    @ObservedObject private var locationManager = LocationManager()
    @State private var isSearching = false
    @State private var searchedWeather: Weather?

    var body: some View {
        NavigationView {
            VStack {
                if let weather = searchedWeather {
                    SearchedWeatherView(weather: weather, searchedCityName: "")
                } else {
                    VStack {
                        if let weather = locationManager.weather {
                            TopHalfView(weather: weather, cityName: locationManager.cityName)
                            BottomHalfView(weather: weather, weeklyForecast: locationManager.filteredWeeklyForecast)
                        } else {
                            Text("Loading...")
                        }
                    }
                    .background(locationManager.weather?.conditionBackground)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut)
                }

                NavigationLink(
                    destination: SearchView(),
                    isActive: $isSearching,
                    label: {
                        EmptyView()
                    }
                )
                .hidden()
            }
            .navigationBarTitle("Weather App", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    isSearching.toggle()
                
                }) {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                        .padding()
                }
                .foregroundColor(.white)
            )
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

