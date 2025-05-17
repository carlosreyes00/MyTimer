//
//  ContentView.swift
//  MyTimer
//
//  Created by Carlos Reyes on 5/17/25.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    private var notifyCenter = UNUserNotificationCenter.current()
    
    @State private var textToNotify: String = ""
    @State private var isFromTextField: Bool = false
    
    var body: some View {
        VStack {
            TextField("Notification text", text: $textToNotify)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Toggle("isFromTextField", isOn: $isFromTextField)
                .padding()
            
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
                
                let request = UNNotificationRequest(identifier: UUID().uuidString,
                                                    content: content,
                                                    trigger: trigger)
                
                notifyCenter.add(request)
                print("notification was scheduled")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ContentView()
}
