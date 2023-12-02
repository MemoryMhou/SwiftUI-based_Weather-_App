//
//  BottomHalfView.swift
//  NEWAPP
//
//  Created by Memory Mhou on 02/12/2023.
//

import Foundation
import SwiftUI
import CoreLocation

struct BottomHalfView: View {
    var weather: Weather
    var weeklyForecast: [Weather]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Min: \(Int(weather.minTemperature))°C")
                    .foregroundColor(.white)
                Spacer()
                Text("Current: \(Int(weather.temperature))°C")
                    .foregroundColor(.white)
                Spacer()
                Text("Max: \(Int(weather.maxTemperature))°C")
                    .foregroundColor(.white)
            }
            .padding()

            Divider()
                .background(Color.white)
                .padding(.horizontal)

            WeeklyForecastView(weeklyForecast: weeklyForecast)
        }
        .background(weather.conditionBackground)
        .foregroundColor(.white)
    }
}
