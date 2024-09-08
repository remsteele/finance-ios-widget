// GlanceWidget.swift
// GlanceWidget
//
// Created by Remington Steele on 1/27/24.
//

import WidgetKit
import SwiftUI
import Charts

struct RevenueStream: Identifiable {
    let id = UUID()
    let name: String
    let value: Double
}

struct FinanceData {
    static var revenueStreams: [RevenueStream] = [
        .init(name: "Positive", value: 70),
        .init(name: "Negative", value: 30)
    ]
// Double(FinanceData.revenueStreams[0].value) / Double(FinanceData.revenueStreams[0].value + FinanceData.revenueStreams[1].value)
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), data: FinanceData.revenueStreams)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), data: FinanceData.revenueStreams)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let entry = SimpleEntry(date: currentDate, data: FinanceData.revenueStreams)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let data: [RevenueStream]
}

//struct GlanceWidgetEntryView: View {
//    var entry: Provider.Entry
////    let financeData = FinanceData()
//    
//    var body: some View {
//        VStack {
//            Text("Positive: " + String(/*financeData.posPercent*/) + "%")
//                .font(.headline)
//                .foregroundColor(.primary)
//            
//            PieChartView(data: entry.data)
//                .frame(width: 150, height: 150)
//                .widgetURL(URL(string: "your_app_custom_url_scheme://open_app_action"))
//        }
//    }
//}
//
//struct PieChartView: View {
//    var data: [RevenueStream]
//    
//    var body: some View {
//        Chart {
//            ForEach(data) { stream in
//                SectorMark(angle: .value("Stream", stream.value), angularInset: 2)
//                    .foregroundStyle(getColor(for: stream.name))
//            }
//        }
//        .background(Color("WidgetBackground")) // Set the background color for the pie chart
//    }
//}


struct GlanceWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        
        PieChartView(data: entry.data)
            .frame(width: 150, height: 150)
            .widgetURL(URL(string: "your_app_custom_url_scheme://open_app_action"))
    }
}
struct PieChartView: View {
    var data: [RevenueStream]
    var body: some View {
        Chart {
            ForEach(data) { stream in
                SectorMark(angle: .value("Stream", stream.value), angularInset: 2)
                    .foregroundStyle(getColor(for: stream.name))
            }
        }
    }
}

struct GlanceWidget: Widget {
    let kind: String = "GlanceWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                GlanceWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                GlanceWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Finance Overview")
        .description("Displays a pie chart of revenue streams.")
    }
}

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

#Preview(as: .systemSmall) {
    GlanceWidget()
} timeline: {
    SimpleEntry(date: .now, data: FinanceData.revenueStreams)
    SimpleEntry(date: .now, data: FinanceData.revenueStreams)
}


