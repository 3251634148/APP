//
//  Message.swift
//  LCX-IOS-APP
//
//  Created by lcx001st on 2025/1/15.
//
import Foundation
import CoreData
import UIKit

struct Message: Identifiable, Codable {
    let id: String
    let sender: User
    let content: String
    let imageURL: String? // 图片的远程 URL
    let timestamp: Date
    let isCurrentUser: Bool

    // 计算属性：根据 imageURL 异步加载图片（本地不缓存）
    var image: UIImage? {
        guard let imageURL = imageURL, let url = URL(string: imageURL) else { return nil }
        if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            return image
        }
        return nil
    }
}
