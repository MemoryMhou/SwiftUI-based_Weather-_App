//
//  TopHalfView.swift
//  NEWAPP
//
//  Created by Memory Mhou on 02/12/2023.
//

import Foundation
import SwiftUI
import CoreLocation

struct TopHalfView: View {
    var weather: Weather
    var cityName: String

    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment: .topTrailing) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(Int(weather.temperature))°C")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.white)
                    HStack {
                        Text(weather.condition)
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.bottom, 5)
                        if let systemSymbol = getSystemSymbol(for: weather.conditionIcon) {
                            Image(systemName: systemSymbol)
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                        }
                    }
                    Text(cityName)
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .frame(maxWidth: .infinity)
            Spacer()
        }
        .background(
            GeometryReader { geometry in
                AsyncImage(url: weather.conditionBackgroundURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .brightness(-0.3)
                } placeholder: {
                    Color.clear
                }
                .clipped()
                .cornerRadius(10)
            }
        )
    }

    private func getSystemSymbol(for conditionIcon: String) -> String? {
        switch conditionIcon {
        case "01d", "01n":
            return "sun.max.fill"
        case "02d", "02n":
            return "cloud.sun.fill"
        case "03d", "03n":
            return "cloud.fill"
        case "04d", "04n":
            return "cloud.fill"
        case "09d", "09n":
            return "cloud.heavyrain.fill"
        case "10d", "10n":
            return "cloud.rain.fill"
        case "11d", "11n":
            return "cloud.bolt.fill"
        case "13d", "13n":
            return "snow"
        case "50d", "50n":
            return "cloud.fog.fill"
        default:
            return nil
        }
    }
}
