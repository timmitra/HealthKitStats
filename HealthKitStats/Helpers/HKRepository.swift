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
    HKObjectType.quantityType(forIdentifier: .stepCount)!
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
}
