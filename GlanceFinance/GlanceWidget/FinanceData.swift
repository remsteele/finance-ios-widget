//
//  FinanceData.swift
//  GlanceFinance
//
//  Created by Remington Steele on 1/27/24.
//

import Foundation

struct RevenueStream: Identifiable {
    let id = UUID()
    let name: String
    let value: Double
}

struct FinanceData {
    static var revenueStreams: [RevenueStream] = [
        .init(name: "Positive", value: 50),
        .init(name: "Negative", value: 30)
    ]
}
