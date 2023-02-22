//
//  Date+Extension.swift
//  HealthKitStats
//
//  Created by Tim Mitra on 2023-02-22.
//

import Foundation

extension Date {
  
  // gives us the first day of the week
  static func firstDayOfWeek() -> Date {
    return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())) ?? Date()
  }
}
