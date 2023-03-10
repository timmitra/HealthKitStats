//
//  Activities.swift
//  HealthKitStats
//
//  Created by Tim Mitra on 2023-02-22.
//

import Foundation

struct Activity: Identifiable {
  var id: String
  var name: String
  var image: String
  
  static func allActivities() -> [Activity] {
    return [
      Activity(id: "activeEnergyBurned", name: "Active Burned Calories", image: "β‘οΈ"),
      Activity(id: "appleExerciseTime", name: "Exercise Time", image: "β³"),
      Activity(id: "appleStandTime", name: "Stand Time", image: "π§ββοΈ"),
      Activity(id: "distanceWalkingRunning", name: "Distance Walking/Running", image: "πββοΈ"),
      Activity(id: "stepCount", name: "Step Count", image: "πΆββοΈ"),
      Activity(id: "bodyMass", name: "Weight", image: "π·")
    ]
  }
}
