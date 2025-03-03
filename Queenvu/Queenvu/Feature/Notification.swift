//
//  Untitled.swift
//  Queenvu
//
//  Created by 신지원 on 3/3/25.
//

import UserNotifications

func sendLocalNotification(title: String, body: String, after seconds: TimeInterval) {
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = .default
    
    // 알림 트리거 설정 (지정된 시간 후 알림 전송)
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
    
    // 요청 생성
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
    // 알림 추가
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("❌ 알림 등록 실패: \(error)")
        } else {
            print("✅ 로컬 알림이 \(seconds)초 후에 등록됨")
        }
    }
}
