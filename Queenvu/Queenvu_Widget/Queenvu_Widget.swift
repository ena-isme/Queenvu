//
//  Queenvu_Widget.swift
//  Queenvu_Widget
//
//  Created by 신지원 on 3/3/25.
//

import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
    let date: Date
    let heartImage: String
}

/// ✅ 위젯의 데이터 제공자 (TimelineProvider)
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), heartImage: "redHeart")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), heartImage: "redHeart")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        let heartImages = ["redHeart", "pinkHeart", "orangeHeart", "blueHeart", "greenHeart", "brownHeart", "purpleHeart", "blackHeart"]

        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, heartImage: heartImages[hourOffset % heartImages.count])
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct Queenvu_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Image(entry.heartImage)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
        }
        .padding()
    }
}

struct Queenvu_Widget: Widget {
    let kind: String = "Queenvu_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                Queenvu_WidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                Queenvu_WidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Heart Widget")
        .description("Shows different heart images over time.")
    }
}

#Preview(as: .systemSmall) {
    Queenvu_Widget()
} timeline: {
    SimpleEntry(date: .now, heartImage: "redHeart")
    SimpleEntry(date: .now, heartImage: "pinkHeart")
}
