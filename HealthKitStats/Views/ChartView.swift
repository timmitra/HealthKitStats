//
//  ChartView.swift
//  HealthKitStats
//
//  Created by Tim Mitra on 2023-02-22.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    let values: [Int]
    let labels: [String]
    let xAxisLabels: [String]
      
    var body: some View {
      Chart() {
        ForEach(0..<values.count, id: \.self ) { idx in
          BarMark (
            x: .value("Date", xAxisLabels[idx]),
            y: .value("Total", values[idx])
          ).foregroundStyle(Color(.orange))
        }
      }.background(Color.primary.opacity(0.2))
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        let values = [213, 343, 3, 3, 344, 435, 342, 30]
        let labels = ["213", "343", "3", "3", "344", "435", "342", "30"]
        let xAxisValues = ["May 30", "May 31", "June 1", "June 2", "June 3", "June 4", "June 5", "June 6"]
        ChartView(values: values, labels: labels, xAxisLabels: xAxisValues)
    }
}
