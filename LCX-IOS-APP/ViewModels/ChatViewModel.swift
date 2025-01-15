//
//  ChatViewModel.swift
//  LCX-IOS-APP
//
//  Created by lcx001st on 2025/1/15.
//

import Foundation
import Firebase
import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var newMessage: String = ""
    private var db = Firestore.firestore()

    let currentUser = User(id: UUID().uuidString, name: "You") // 模拟当前用户

    init() {
        loadMessages()
    }

    // 加载消息（实时监听）
    func loadMessages() {
        db.collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                self.messages = documents.compactMap { doc -> Message? in
                    let data = doc.data()
                    guard let senderID = data["senderID"] as? String,
                          let senderName = data["senderName"] as? String,
                          let content = data["content"] as? String,
                          let timestamp = data["timestamp"] as? Timestamp else {
                        return nil
                    }
                    let isCurrentUser = senderID == self.currentUser.id
                    return Message(
                        id: doc.documentID,
                        sender: User(id: senderID, name: senderName),
                        content: content,
                        imageURL: data["imageURL"] as? String,
                        timestamp: timestamp.dateValue(),
                        isCurrentUser: isCurrentUser
                    )
                }
            }
    }

    // 发送文本消息
    func sendMessage() {
        guard !newMessage.isEmpty else { return }
        let message = [
            "senderID": currentUser.id,
            "senderName": currentUser.name,
            "content": newMessage,
            "timestamp": Timestamp(date: Date())
        ] as [String: Any]
        db.collection("messages").addDocument(data: message)
        newMessage = ""
    }

    // 发送图片消息
    func sendImageMessage(imageURL: String) {
        let message = [
            "senderID": currentUser.id,
            "senderName": currentUser.name,
            "content": "",
            "imageURL": imageURL,
            "timestamp": Timestamp(date: Date())
        ] as [String: Any]
        db.collection("messages").addDocument(data: message)
    }
}
