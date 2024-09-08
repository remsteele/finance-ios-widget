//
//  ContentView.swift
//  FinanceAtAGlance
//
//  Created by Remington Steele on 1/27/24.
//
import SwiftUI
import UIKit
import Foundation
import Charts


struct ContentView: View {
    @ObservedObject private var dataFrame = DataFrame(positive: 20, negative: 80)

    var body: some View {
        NavigationStack {
            VStack {
                Chart {
                    SectorMark(angle: .value("Stream", dataFrame.positive), angularInset: 2)
                        .foregroundStyle(getColor(for: "Positive"))
                    SectorMark(angle: .value("Stream", dataFrame.negative), angularInset: 2)
                        .foregroundStyle(getColor(for: "Negative"))
                }
            }
            .padding()
            .navigationTitle("Finance at a Glance")
        }
        .onAppear {
            updateDataFrame(dataFrame: dataFrame)
//            updateToHalf(dataFrame: dataFrame)
        }
    }
}

//func updateToHalf(dataFrame: DataFrame) {
//    dataFrame.positive = 50
//    dataFrame.negative = 50
//}

func updateDataFrame(dataFrame: DataFrame) {
    let url = URL(string: "localhost:8000/api/sp500/")!
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else {
            print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
            return
        }

        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let positive = json["Positive"] as? Int,
               let negative = json["Negative"] as? Int {
                dataFrame.positive = positive
                dataFrame.negative = negative
                print("Data updated - Positive: \(positive), Negative: \(negative)")
            } else {
                print("Invalid JSON format")
            }
        } catch {
            print("Error parsing JSON: \(error.localizedDescription)")
        }
    }
    
    task.resume()
}

//func updateDataFrame(dataFrame: DataFrame) {
//    let url = URL(string: "https://6ac3-130-191-100-71.ngrok-free.app")!
//    
//    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
//        guard let data = data else { return }
//        
//        
//        
//        dataFrame.positive = 50
//        dataFrame.negative = 50
//    }
//    task.resume()
//}



func getColor(for streamName: String) -> Color {
    switch streamName {
    case "Positive":
        return Color(red: 0.47, green: 0.87, blue: 0.47)
    case "Negative":
        return Color(red: 1, green: 0.41, blue: 0.38)
    default:
        return Color.gray // or any default color
    }
}

class DataFrame: ObservableObject {
    @Published var positive: Int = 20
    @Published var negative: Int = 80
    init(positive: Int, negative: Int) {
        self.positive = positive
        self.negative = negative
    }
}


//#Preview {
//    ContentView()
//}
