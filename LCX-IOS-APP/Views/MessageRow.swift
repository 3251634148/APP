//
//  TestFile.swift
//  LCX-IOS-APP
//
//  Created by lcx001st on 2025/1/15.
//

import Foundation
import SwiftUI

struct MessageRow: View {
    let message: Message

    var body: some View {
        HStack {
            if message.isCurrentUser {
                Spacer() // 当前用户消息对齐右侧
            }

            VStack(alignment: .leading, spacing: 5) {
                // 文本消息
                if !message.content.isEmpty {
                    Text(message.content)
                        .padding(10)
                        .background(message.isCurrentUser ? Color.blue : Color.gray.opacity(0.2))
                        .foregroundColor(message.isCurrentUser ? .white : .black)
                        .cornerRadius(10)
                }

                // 图片消息
                if let imageURL = message.imageURL, let url = URL(string: imageURL) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 200)
                                .cornerRadius(10)
                        case .failure:
                            Text("无法加载图片")
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
            }

            if !message.isCurrentUser {
                Spacer() // 对方消息对齐左侧
            }
        }
        .padding(message.isCurrentUser ? .leading : .trailing, 50)
        .padding(.vertical, 5)
    }
}
