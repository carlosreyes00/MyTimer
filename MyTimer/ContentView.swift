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
    
    @State private var timeRemaining: Int = 10
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(timeRemaining)")
            Button("Start Timer") {
                executeTimer()
            }
            Spacer()
            VStack {
                TextField("Notification text", text: $textToNotify)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                    .padding([.horizontal, .top])
                
                Toggle("isFromTextField", isOn: $isFromTextField)
                    .padding(.horizontal)
                
                Button("Request Permission") {
                    print("button was pressed")
                    notifyCenter.requestAuthorization(
                        options: [.alert, .badge, .sound]) { success, error in
                            if success {
                                print("All set!")
                            } else if let error {
                                print(error.localizedDescription)
                            }
                        }
                }
                .buttonStyle(.bordered)
                
                Button("Schedule Notification") {
                    print("scheduling notification")
                    let content = UNMutableNotificationContent()
                    content.title = "Time's up"
                    if isFromTextField {
                        content.subtitle = "\(textToNotify)"
                    } else {
                        content.subtitle = "The timer for \(Int.random(in: 1...10)) minutes is done."
                    }
                    content.sound = UNNotificationSound.default
                    content.badge = NSNumber(value: 2)
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3,
                                                                    repeats: false)
                    
                    let request = UNNotificationRequest(
                        identifier: UUID().uuidString,
                        content: content,
                        trigger: trigger
                    )
                    
                    notifyCenter.add(request)
                    print("notification was scheduled")
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom)
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
    
    private func executeTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in 
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
    }
}

#Preview {
    ContentView()
}
