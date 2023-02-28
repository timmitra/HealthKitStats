//
//  HKRepository.swift
//  HealthKitStats
//
//  Created by Tim Mitra on 2023-02-22.
//

import Foundation
import HealthKit

final class HKRepository {
  var store: HKHealthStore?
  
  let allTypes = Set([
    HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
    HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
    HKObjectType.quantityType(forIdentifier: .appleMoveTime)!,
    HKObjectType.quantityType(forIdentifier: .appleStandTime)!,
    HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
    HKObjectType.quantityType(forIdentifier: .stepCount)!,
    HKObjectType.quantityType(forIdentifier: .bodyMass)!
  ])
  
  var query: HKStatisticsCollectionQuery?
  
  init() {
    store = HKHealthStore()
  }
  
  func requestAuthorization(completion: @escaping (Bool) -> Void) {
    guard let store = store else {
      return
    }
    
    store.requestAuthorization(toShare: [], read: allTypes) { success, error in
      completion(success)
    }
  }
  
  func requestHealthStat(by category: String, completion: @escaping ([HealthStat]) -> Void) {
    guard let store = store, let type = HKQuantityType.quantityType(forIdentifier: typeByCategory(category: category)) else {
      return
    }
    
    let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
    let endDate = Date()
    let anchorDate = Date.firstDayOfWeek()
    let dailyComponent = DateComponents(day: 1)
    
    var healthStats = [HealthStat]()
    
    let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
    if (category != "bodyMass") {
      query = HKStatisticsCollectionQuery(quantityType: type, quantitySamplePredicate: predicate, options: .cumulativeSum,anchorDate: anchorDate, intervalComponents: dailyComponent)
    } else {
      let mass = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
      query = HKStatisticsCollectionQuery(quantityType: mass, quantitySamplePredicate: predicate, anchorDate: anchorDate, intervalComponents: dailyComponent)
    }
    query?.initialResultsHandler = { query, statistics, error in
      statistics?.enumerateStatistics(from: startDate, to: endDate, with: { stats, _ in
        let stat = HealthStat(stat: stats.sumQuantity(), date: stats.startDate)
        healthStats.append(stat)
      })
      
      completion(healthStats)
     }
    
    guard let query = query else {
      return
    }
    store.execute(query)
  }
  
  private func typeByCategory(category: String) -> HKQuantityTypeIdentifier {
    switch category {
    case "activeEnergyBurned":
      return .activeEnergyBurned
    case "appleExerciseTime":
      return .appleExerciseTime
    case "appleMoveTime":
      return .appleMoveTime
    case "appleStandTime":
      return .appleStandTime
    case "distanceWalkingRunning":
      return .distanceWalkingRunning
    case "stepCount":
      return .stepCount
    case "bodyMass":
      return .bodyMass
    default:
      return .stepCount
    }
  }
}
