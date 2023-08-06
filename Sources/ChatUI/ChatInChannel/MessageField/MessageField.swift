//
//  MessageField.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import Combine
import SwiftUI
import PhotosUI

/**
 The view for sending messages.
 
 When creating a `MessageField`, you can provide an action for how to handle a new `MessageStyle` information in the `onSend` parameter. `MessageStyle` can contain different types of messages, such as text, media (photo, video, document, contact), and voice.

 ```swift
 MessageField { messageStyle in
     viewModel.sendMessage($0)
 }
 ```
 
 To handle menu items, assign state property to `isMenuItemPresented` parameter.
 
 ```swift
 MessageField(isMenuItemPresented: $isMenuItemPresented) { ... }

 if isMenuItemPresented {
     MyMenuItemList()
 }
 ```
 
 To publish a new message, you can create a new `MessageStyle` object and send it using `send(_:)`.

 ```swift
 let _ = Empty<Void, Never>()
     .sink(
         receiveCompletion: { _ in
             // Create `MessageStyle` object
             let style = MessageStyle.text("{TEXT}")
             // Publish the created style object via `send(_:)`
             sendMessagePublisher.send(style)
         },
         receiveValue: { _ in }
     )
 ```
 
 You can subscribe to `sendMessagePublisher` to handle new messages.

 ```swift
 .onReceive(sendMessagePublisher) { messageStyle in
     // Handle `messageStyle` here (e.g., sending message with the style)
 }
 ```
 */
public struct MessageField: View {

    @EnvironmentObject private var configuration: ChatConfiguration
    @Environment(\.appearance) var appearance

    @FocusState private var isTextFieldFocused: Bool
    @State private var text: String = ""
    @State private var textFieldHeight: CGFloat = 20
    @State private var giphyKey: String?
    @State private var mediaData: Data?
    
    // Media
    @State private var selectedItem: PhotosPickerItem? = nil
    
    @Binding var isMenuItemPresented: Bool
    
    @State private var isGIFPickerPresented: Bool = false
    @State private var isCameraFieldPresented: Bool = false
    @State private var isVoiceFieldPresented: Bool = false
    
    let options: [MessageOption]
    let showsSendButtonAlways: Bool
    let characterLimit: Int?
    let onSend: (_ messageStyle: MessageStyle) -> ()
    
    private var leftSideOptions: [MessageOption] {
        options.filter { $0 != .giphy }
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            HStack(alignment: .bottom) {
                if isTextFieldFocused, leftSideOptions.count > 1 {
                    Button(action: onTapHiddenButton) {
                        appearance.images.buttonHidden.medium
                            .tint(appearance.tint)
                    }
                    .frame(width: 36, height: 36)
                } else {
                    if options.contains(.menu) {
                        // More Button
                        Button(action: onTapMore) {
                            appearance.images.menu.medium
                        }
                        .tint(appearance.tint)
                        .frame(width: 36, height: 36)
                    }
                    
                    // Camera Button
                    if options.contains(.camera) {
                        Button(action: onTapCamera) {
                            appearance.images.camera.medium
                        }
                        .tint(appearance.tint)
                        .disabled(isMenuItemPresented)
                        .frame(width: 36, height: 36)
                    }
                    
                    // Photo Library Button
                    if options.contains(.photoLibrary) {
                        PhotosPicker(
                            selection: $selectedItem,
                            matching: .images,
                            photoLibrary: .shared()
                        ) {
                            appearance.images.photoLibrary.medium
                        }
                        .tint(appearance.tint)
                        .disabled(isMenuItemPresented)
                        .frame(width: 36, height: 36)
                        .onChange(of: selectedItem) { newItem in
                            Task {
                                // Retrive selected asset in the form of Data
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    self.onSelectPhoto(data: data)
                                }
                            }
                        }
                    }
                    
                    // Mic Button
                    if options.contains(.mic) {
                        Button(action: onTapMic) {
                            appearance.images.mic.medium
                        }
                        .tint(appearance.tint)
                        .disabled(isMenuItemPresented)
                        .frame(width: 36, height: 36)
                    }
                }
                
                // TextField
                HStack(alignment: .bottom) {
                    MessageTextField(text: $text, height: $textFieldHeight, characterLimit: characterLimit)
                        .frame(height: textFieldHeight < 90 ? textFieldHeight : 90)
                        .padding(.leading, 9)
                        .padding(.trailing, 4)
                        .focused($isTextFieldFocused)
                    
                    // Giphy Button
                    if options.contains(.giphy) {
                        Button(action: onTapGiphy) {
                            appearance.images.giphy.medium
                        }
                        .tint(appearance.tint)
                        .disabled(isMenuItemPresented)
                    }
                }
                .padding(6)
                .background {
                    appearance.secondaryBackground
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                }
                
                // Send Button
                if showsSendButtonAlways || !text.isEmpty {
                    Button(action: onTapSend) {
                        appearance.images.send.medium
                    }
                    .frame(width: 36, height: 36)
                    .tint(appearance.tint)
                    .disabled(text.isEmpty)
                }
            }
            
            if isVoiceFieldPresented {
                VoiceField(isPresented: $isVoiceFieldPresented)
            }
            
            if isCameraFieldPresented {
                CameraField(isPresented: $isCameraFieldPresented)
            }
        }
        .sheet(isPresented: $isGIFPickerPresented) {
            if let giphyKey = configuration.giphyKey {
                GiphyPicker(giphyKey: giphyKey, giphyConfig: configuration.giphyConfig)
                        .ignoresSafeArea()
                        .presentationDetents([.fraction(configuration.giphyConfig.presentationDetents)])
                        .presentationDragIndicator(.hidden)
            } else {
                Text("No Giphy Key")
            }
        }
        .onReceive(sendMessagePublisher) { messageStyle in
            onSend(messageStyle)
        }
    }
    
    
    public init(
        options: [MessageOption] = MessageOption.all,
        showsSendButtonAlways: Bool = false,
        characterLimit: Int? = nil,
        isMenuItemPresented: Binding<Bool> = .constant(false),
        onSend: @escaping (_ messageStyle: MessageStyle) -> ()
    ) {
        self.options = options
        self.showsSendButtonAlways = showsSendButtonAlways
        self.characterLimit = characterLimit
        self._isMenuItemPresented = isMenuItemPresented
        self.onSend = onSend
    }
    
    func onTapHiddenButton() {
        isTextFieldFocused = false
    }
    
    func onTapMore() {
        isMenuItemPresented.toggle()
    }

    func onTapCamera() {
        dismissMenuItems()
        isCameraFieldPresented = true
    }
    
    func onSelectPhoto(data: Data) {
        onSend(.media(.photo(data)))
    }
    
    func onTapMic() {
        dismissMenuItems()
        isVoiceFieldPresented = true
    }
    
    /// Shows ``GiphyPicker``
    func onTapGiphy() {
        dismissMenuItems()
        isGIFPickerPresented = true
    }
    
    func onTapSend() {
        guard !text.isEmpty else { return }
        onSend(.text(text))
        text = ""
    }

    func dismissMenuItems() {
        isMenuItemPresented = false
        isCameraFieldPresented = false
        isVoiceFieldPresented = false
    }
}
