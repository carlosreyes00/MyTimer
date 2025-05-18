//
//  Buttons.swift
//  MyTimer
//
//  Created by Carlos Reyes on 5/18/25.
//

import SwiftUI
import NotificationCenter

struct NotificationButtons: View {
    let notificationCenter = UNUserNotificationCenter.current()
    
    var textToNotify: String
    var isFromTextField: Bool
    
    var body: some View {
        Button("Request Permission") {
            print("button was pressed")
            notificationCenter.requestAuthorization(
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
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                            repeats: false)
            
            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: trigger
            )
            
            notificationCenter.add(request)
            if isFromTextField {
                print("notification: \(textToNotify)")
            } else {
                print("notifcation: random number")
            }
        }
        .buttonStyle(.borderedProminent)
        .padding(.bottom)
    }
}

#Preview {
    NotificationButtons(textToNotify: "preview text", isFromTextField: false)
}
