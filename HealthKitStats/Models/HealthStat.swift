//
//  HealthStat.swift
//  HealthKitStats
//
//  Created by Tim Mitra on 2023-02-22.
//

import Foundation
import HealthKit

struct HealthStat: Identifiable {
  let id = UUID()
  let stat: HKQuantity?
  let date: Date
}
