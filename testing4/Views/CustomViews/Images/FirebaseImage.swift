//
//  FirebaseImage.swift
//  testing4
//
//  Created by Alex Polovoy on 28.03.25.
//

import SwiftUI
import FirebaseStorage

struct FirebaseImageWide: View {
    @StateObject private var imageLoader: Loader
    
    init(id: String) {
        _imageLoader = StateObject(wrappedValue: Loader(id))
    }
    
    var body: some View {
        AsyncImage(url: URL(string: imageLoader.url?.absoluteString ?? "")) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: 320, height: 240)
        } placeholder: {
            Image("food-placeholder")
                .resizable()
                .scaledToFill()
                .frame(width: 320, height: 240)
        }
    }
}

struct FirebaseImageSmall: View {
    @StateObject private var imageLoader: Loader
    
    init(id: String) {
        _imageLoader = StateObject(wrappedValue: Loader(id))
    }
    
    var body: some View {
        AsyncImage(url: URL(string: imageLoader.url?.absoluteString ?? "")) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 90)
                .cornerRadius(8)
        } placeholder: {
            Image("food-placeholder")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 90)
                .cornerRadius(8)
        }
    }
}

class Loader: ObservableObject {
    @Published var url: URL?
    
    init(_ id: String) {
        let ref = Storage.storage().reference().child("images").child(id)
        ref.downloadURL { (url, error) in
            if let error = error {
                print("\(error)")
            }
            DispatchQueue.main.async {
                self.url = url
            }
        }
    }
}
