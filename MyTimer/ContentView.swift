//
//  ContentView.swift
//  MyTimer
//
//  Created by Carlos Reyes on 5/17/25.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    let notifyCenter = UNUserNotificationCenter.current()
    
    @State private var textToNotify: String = ""
    @State private var isFromTextField: Bool = false
    
    @State private var initialTime = 30
    @State private var timeRemaining = 30
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                
                HStack {
                    Button {
                        executeTimer()
                    } label: {
                        Image(systemName: "play")
                    }
                    
                    Button {
                        timer?.invalidate()
                    } label: {
                        Image(systemName: "pause")
                    }
                    
                    Button {
                        timer?.invalidate()
                        timeRemaining = initialTime
                    } label: {
                        Image(systemName: "stop")
                    }
                }
                .font(.title)
            }
            Spacer()
            VStack {
                TextField("Notification text", text: $textToNotify)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                    .padding([.horizontal, .top])
                
                Toggle("isFromTextField", isOn: $isFromTextField)
                    .padding(.horizontal)
                
                NotificationButtons(textToNotify: textToNotify, isFromTextField: isFromTextField)
            }
            .background (
                RoundedRectangle(cornerRadius: 20)
                    .fill(.blue.opacity(0.1))
                    .stroke(Color.black, lineWidth: 3)
                    .shadow(color: .blue, radius: 5, x: 2, y: 2)
            )
            .padding()
        }
    }
    
    private  func executeTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
    }
}

#Preview {
    ContentView()
}
