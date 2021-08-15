//
//  ContentView.swift
//  Flashzilla
//
//  Created by Bruce Gilmour on 2021-08-11.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        Text("Hello, world!")
    }
}

struct ReceiveNotificationTestView: View {

    var body: some View {
        Text("Hello, world!")
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                print("Moving to the background!")
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                print("Moving back to the foreground!")
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)) { _ in
                print("The user took a screenshot!")
            }
    }
}

struct TimerStartStopTestViewView: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0

    var body: some View {
        Text("Hello, world!")
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }
                counter += 1
            }
    }

}

struct TimerTestView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text("Hello, world!")
            .onReceive(timer) { time in
                print("The time is now \(time)")
            }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
