//
//  NextMessageField.swift
//  
//
//  Created by Jaesung Lee on 2023/03/28.
//

import SwiftUI

// TODO: Provide pre-implemented send button

/**
 The view for sending messages.
 
 When creating a ``NextMessageField``, you can provide an action for how to handle a new ``MessageStyle`` information in the `onSend` parameter. ``MessageStyle`` contains different types of messages, such as text, media (photo, video, document, contact) and voice. you can also provide a message-sending button by using ``sendMessagePublisher`` in the `rightLabel`. ``sendMessagePublisher`` will invoke `onSend` handler.
 
 ```swift
 @State private var text: String = ""
 
 NextMessageField(text) { messageStyle in
    guard !text.isEmpty else { return }
    viewModel.sendMessage($0)
    text = ""
 } rightLabel: {
    Button {
        // send message by using `sendMessagePublisher`. This will invoke `onSend` handler.
        sendMessagePublisher.send(.text(text))
    } label: {
        // send button icon
        Image.send.medium
    }
    .frame(width: 36, height: 36)
 }
 ```
 
 To add some button on the left of the text field,
 ```swift
 NextMessageField(text) { messageStyle in
    ...
 } leftLabel: {
    HStack {
        Button(aciton: showCamera) {
            Image.camera.medium
        }
        .frame(width: 36, height: 36)
 
        Button(action: showLibrary) {
            Image.photoLibrary.medium
        }
        .frame(width: 36, height: 36)
 }
 ```
 
 To add some button on the right of the text field,
 ```swift
 NextMessageField(text) { messageStyle in
    ...
 } rightLabel: {
    HStack {
        Button(aciton: { sendMessagePublisher.send(.text(text)) }) {
            Image.send.medium
        }
        .frame(width: 36, height: 36)
    }
 }
 ```
 
 To publish a new message, you can create a new `MessageStyle` object and send it using `send(_:)`.

 ```swift
 // Create `MessageStyle` object
 let style = MessageStyle.text("{TEXT}")
 // Publish the created style object via `send(_:)`
 sendMessagePublisher.send(style)
 ```
 
 You can make other views to subscribe to `sendMessagePublisher` to handle new messages.

 ```swift
 .onReceive(sendMessagePublisher) { messageStyle in
     // Handle `messageStyle` here (e.g., sending message with the style)
 }
 ```
 */
public struct NextMessageField<LeftLabel: View, RightLabel: View>: View {
    @EnvironmentObject private var configuration: ChatConfiguration
    
    @Environment(\.appearance) var appearance
    
    @Binding public var text: String

    @FocusState private var isTextFieldFocused: Bool
    @State private var textFieldHeight: CGFloat = 20
    
    let leftLabel: (() -> LeftLabel)?
    let rightLabel: (() -> RightLabel)?
    let showsSendButtonAlways: Bool = false
    let characterLimit: Int?
    let onSend: (_ messageStyle: MessageStyle) -> ()
    
    public var body: some View {
        HStack(alignment: .bottom) {
            if let leftLabel {
                leftLabel()
                    .tint(appearance.tint)
            }
                
            // TextField
            HStack(alignment: .bottom) {
                MessageTextField(text: $text, height: $textFieldHeight, characterLimit: characterLimit)
                    .frame(height: textFieldHeight < 90 ? textFieldHeight : 90)
                    .padding(.leading, 9)
                    .padding(.trailing, 4)
                    .focused($isTextFieldFocused)
            }
            .padding(6)
            .background {
                appearance.secondaryBackground
                    .clipShape(RoundedRectangle(cornerRadius: 18))
            }
            
            if let rightLabel {
                rightLabel()
                    .tint(appearance.tint)
            }
        }
        .padding(16)
        .onReceive(sendMessagePublisher) { messageStyle in
            onSend(messageStyle)
        }
    }
    
    public init(
        _ text: Binding<String>,
        characterLimit: Int? = nil,
        onSend: @escaping (_ messageStyle: MessageStyle) -> (),
        @ViewBuilder leftLabel: @escaping () -> LeftLabel,
        @ViewBuilder rightLabel: @escaping () -> RightLabel
    ) {
        self._text = text
        self.characterLimit = characterLimit
        self.onSend = onSend
        self.leftLabel = leftLabel
        self.rightLabel = rightLabel
    }
    
    public init(
        _ text: Binding<String>,
        characterLimit: Int? = nil,
        onSend: @escaping (_ messageStyle: MessageStyle) -> (),
        @ViewBuilder rightLabel: @escaping () -> RightLabel
    ) where LeftLabel == EmptyView {
        self._text = text
        self.characterLimit = characterLimit
        self.onSend = onSend
        self.leftLabel = nil
        self.rightLabel = rightLabel
    }
    
    public init(
        _ text: Binding<String>,
        characterLimit: Int? = nil,
        onSend: @escaping (_ messageStyle: MessageStyle) -> (),
        @ViewBuilder leftLabel: @escaping () -> LeftLabel
    ) where RightLabel == EmptyView {
        self._text = text
        self.characterLimit = characterLimit
        self.onSend = onSend
        self.leftLabel = leftLabel
        self.rightLabel = nil
    }
    
    public init(
        _ text: Binding<String>,
        characterLimit: Int? = nil,
        onSend: @escaping (_ messageStyle: MessageStyle) -> ()
    ) where LeftLabel == EmptyView, RightLabel == EmptyView {
        self._text = text
        self.characterLimit = characterLimit
        self.onSend = onSend
        self.leftLabel = nil
        self.rightLabel = nil
    }
}
