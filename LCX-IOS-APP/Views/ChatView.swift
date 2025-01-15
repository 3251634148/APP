//
//  ContentView.swift
//  LCX-IOS-APP
//
//  Created by lcx001st on 2025/1/15.
//
import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.messages) { message in
                        MessageRow(message: message)
                    }
                }
            }

            HStack {
                TextField("输入消息...", text: $viewModel.newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: viewModel.sendMessage) {
                    Text("发送")
                }

                Button(action: { showImagePicker.toggle() }) {
                    Image(systemName: "photo")
                }
            }
            .padding()

            .sheet(isPresented: $showImagePicker) {
                ImagePickerView(selectedImage: $selectedImage)
            }
        }
        .onChange(of: selectedImage) { image in
            guard let image = image else { return }
            // 模拟上传图片并返回 URL
            let imageURL = "https://example.com/image.jpg"
            viewModel.sendImageMessage(imageURL: imageURL)
            selectedImage = nil
        }
    }
}
