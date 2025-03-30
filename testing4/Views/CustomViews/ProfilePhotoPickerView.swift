//
//  ProfilePhotoPickerView.swift
//  testing4
//
//  Created by Alex Polovoy on 30.03.25.
//

import SwiftUI
import PhotosUI

struct ProfilePhotoPickerView: View {
    @State private var avatarImage: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    
    var body: some View {
        ZStack {
            VStack {
                PhotosPicker(selection: $photosPickerItem, matching: .images) {
                    Image(uiImage: avatarImage ?? UIImage(named: "defaultAvatar")!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding()
                }
                .onChange(of: photosPickerItem) { _, _ in
                    Task {
                        if let photosPickerItem,
                           let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                            if let imagePicked = UIImage(data: data) {
                                avatarImage = imagePicked
                                saveImageToUserDefaults(image: imagePicked)
                            }
                        }
                        
                        photosPickerItem = nil
                    }
                }
                .overlay(alignment: .topTrailing) {
                    Image(systemName: "camera.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 35, alignment: .topTrailing)
                        .foregroundStyle(Color.accentColor)
                }
            }
        }
        .onAppear {
            loadImageFromUserDefaults()
        }
    }
    
    private func saveImageToUserDefaults(image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            UserDefaults.standard.set(imageData, forKey: "profileImage")
        }
    }
    
    private func loadImageFromUserDefaults() {
        if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
           let image = UIImage(data: imageData) {
            avatarImage = image
        }
    }
}

#Preview {
    ProfilePhotoPickerView()
}

