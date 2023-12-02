//
//  WeeklyForecastView.swift
//  NEWAPP
//
//  Created by Memory Mhou on 02/12/2023.
//

import Foundation
import SwiftUI
import CoreLocation


struct WeeklyForecastView: View {
    var weeklyForecast: [Weather]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            let sortedDays = weeklyForecast.map(\.dayOfWeek).sorted(by: { day1, day2 in
                let logicalOrder = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
                guard let index1 = logicalOrder.firstIndex(of: day1),
                      let index2 = logicalOrder.firstIndex(of: day2) else {
                    return false
                }
                return index1 < index2
            })

            ForEach(sortedDays, id: \.self) { day in
                if let dayWeather = weeklyForecast.first(where: { $0.dayOfWeek == day }) {
                    HStack {
                        Text(dayWeather.dayOfWeek)
                            .foregroundColor(.white)
                        Spacer()

                       
                        Image(systemName: "sun.max.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.white)
                            .padding(.horizontal, 5)
                            .fixedSize()

                        Spacer()

                        Text("\(Int(dayWeather.maxTemperature))°C")
                            .foregroundColor(.white)
                    }
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.2)))
                    .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}
