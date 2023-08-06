//
//  MessageField.Previews.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import SwiftUI

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Preview()
                .previewDisplayName("Message Field")
            
            VStack {
                MessageField(options: [.mic]) { _ in }
                
                MessageField(options: [.camera, .photoLibrary]) { _ in }
                
                MessageField(options: [.menu]) { _ in }
                
                MessageField(options: [.giphy]) { _ in }
                
                MessageField(options: MessageOption.all) { _ in }
                
            }
                .previewDisplayName("Message Field Options")
            
            MessageField(showsSendButtonAlways: true) { _ in }
                .previewDisplayName("Showing Send Button Always")
            
            MenuItemPreview()
                .previewDisplayName("Menu items")

            LocationSelectorPreview()
                .previewDisplayName("Location Selector")
            
//            VoiceField(isPresented: .constant(true))
//                .previewDisplayName("Voice Field")
        }
        .environmentObject(
            ChatConfiguration(
                userID: User.user1.id,
                giphyKey: "wj5tEh9nAwNHVF3ZFavQ0zoaIyt8HZto"
            )
        )
    }
    
    struct Preview: View {
        @State private var pendingMessage: Message?
        @State private var isMenuItemPresented: Bool = false
        
        var body: some View {
            VStack {
                if let pendingMessage = pendingMessage {
                    Text(pendingMessage.id)
                    
                    Text(String(describing: pendingMessage.style))
                }
                
                Spacer()
                
                MessageField(isMenuItemPresented: $isMenuItemPresented) { messageStyle in
                    pendingMessage = Message(
                        id: UUID().uuidString,
                        sender: User.user1,
                        sentAt: Date().timeIntervalSince1970,
                        readReceipt: .sending,
                        style: messageStyle
                    )
                }
                
                if isMenuItemPresented {
                    LocationSelector(isPresented: .constant(true))
                }
            }
        }
    }
    
    struct MenuItemPreview: View {
        @Environment(\.colorScheme) var colorScheme
        @Environment(\.appearance) var appearance
        
        @State private var isMenuItemPresented: Bool = false
        
        var body: some View {
            VStack {
                Spacer()
                
                MessageField(
                    options: [.menu],
                    isMenuItemPresented: $isMenuItemPresented
                ) { _ in }
                
                if isMenuItemPresented {
                    additionalContent
                }
            }
            .alert(
                Text("Menu"),
                isPresented: $isMenuItemPresented
            ) {
                Button(role: .destructive) {
                    // Handle the deletion.
                } label: {
                    Text("Camera")
                }
            }
        }
        
        var additionalContent: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    Button(action: { }) {
                        appearance.images.getLocation(colorScheme).large
                            .foregroundColor(.white)
                            .padding(14)
                            .background {
                                Color(.cyan)
                                    .clipShape(Circle())
                            }
                    }
                    
                    Button(action: { }) {
                        appearance.images.getMusic(colorScheme).large
                            .foregroundColor(.white)
                            .padding(14)
                            .background {
                                Color(.systemPink)
                                    .clipShape(Circle())
                            }
                    }
                }
            }
            .background { appearance.secondaryBackground }
            .frame(height: 124)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    struct LocationSelectorPreview: View {
        var body: some View {
            VStack {
                Spacer()
                
                LocationSelector(isPresented: .constant(true))
            }
            
        }
    }
    
    struct CameraViewPreview: View {
        var body: some View {
            CameraField(isPresented: .constant(true))
        }
    }
}
