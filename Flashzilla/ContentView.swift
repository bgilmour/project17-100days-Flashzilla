//
//  ContentView.swift
//  Flashzilla
//
//  Created by Bruce Gilmour on 2021-08-11.
//

import SwiftUI

struct ContentView: View {
    @State private var offset = CGSize.zero
    @State private var isDragging = false

    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }

        let pressGesture = LongPressGesture()
            .onEnded { _ in
                withAnimation {
                    isDragging = true
                }
            }

        let combined = pressGesture.sequenced(before: dragGesture)

        return ZStack {
            Circle()
                .fill(Color.red)
            Text("Circle")
        }
        .frame(width: 64, height: 64)
        .scaleEffect(isDragging ? 1.5 : 1)
        .offset(offset)
        .gesture(combined)
    }
}

struct SequencedGestureTestView: View {
    @State private var offset = CGSize.zero
    @State private var isDragging = false

    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }

        let pressGesture = LongPressGesture()
            .onEnded { _ in
                withAnimation {
                    isDragging = true
                }
            }

        let combined = pressGesture.sequenced(before: dragGesture)

        return ZStack {
            Circle()
                .fill(Color.red)
            Text("Circle")
        }
        .frame(width: 64, height: 64)
        .scaleEffect(isDragging ? 1.5 : 1)
        .offset(offset)
        .gesture(combined)
    }
}

struct SimultaneousGestureTestView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .onTapGesture {
                    print("Text tapped")
                }
        }
        .simultaneousGesture(
            TapGesture()
                .onEnded  { _ in
                    print("VStack tapped")
                }
        )
    }
}

struct HighPriorityGesturetestView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .onTapGesture {
                    print("Text tapped")
                }
        }
        .highPriorityGesture(
            TapGesture()
                .onEnded  { _ in
                    print("VStack tapped")
                }
        )
    }
}

struct ClashingGestureView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .onTapGesture {
                    print("Text tapped")
                }
        }
        .onTapGesture {
            print("VStack tapped")
        }
    }
}

struct RotationGestureTestView: View {
    @State private var currentAmount: Angle = .degrees(0)
    @State private var finalAmount: Angle = .degrees(0)

    var body: some View {
        Text("Hello, world!")
            .rotationEffect(finalAmount + currentAmount)
            .gesture(
                RotationGesture()
                    .onChanged { angle in
                        currentAmount = angle
                    }
                    .onEnded { angle in
                        finalAmount += currentAmount
                        currentAmount = .degrees(0)
                    }
            )
    }
}

struct MagnificationGestureTestView: View {
    @State private var currentAmount: CGFloat = 0
    @State private var finalAmount: CGFloat = 1

    var body: some View {
        Text("Hello, world!")
            .scaleEffect(finalAmount + currentAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged { amount in
                        currentAmount = amount - 1
                    }
                    .onEnded { amount in
                        finalAmount += currentAmount
                        currentAmount = 0
                    }
            )
    }
}

struct LongPressInProgressTestView: View {
    var body: some View {
        Text("Hello, world!")
            .onLongPressGesture(minimumDuration: 1, pressing: { inProgress in
                print("In progress: \(inProgress)")
            }) {
                print("LongPressed (2s)")
            }
    }
}

struct TimedLongPressTestView: View {
    var body: some View {
        Text("Hello, world!")
            .onLongPressGesture(minimumDuration: 2) {
                print("LongPressed (2s)")
            }
    }
}

struct LongPressTestView: View {
    var body: some View {
        Text("Hello, world!")
            .onLongPressGesture {
                print("LongPressed!")
            }
    }
}

struct DoubleTapTestView: View {
    var body: some View {
        Text("Hello, world!")
            .onTapGesture(count: 2) {
                print("Double tapped!")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
