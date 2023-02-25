#  MessageField

The message field is a UI component for sending messages.

## How to send a new message

When creating a `MessageField`, you can provide an action for how to handle a new `MessageStyle` information in the `onSend` parameter. `MessageStyle` can contain different types of messages, such as text, media (photo, video, document, contact), and voice.

```swift
MessageField { messageStyle in
    viewModel.sendMessage($0)
}
```

### Supported message styles

- [x] text
- [x] voice
- [x] photo library
- [x] giphy
- [x] location
- [ ] camera (*coming soon*)
- [ ] document (*coming soon*)
- [ ] contacts (*coming soon*)

## Handling menu items

```swift
MessageField(isMenuItemPresented: $isMenuItemPresented) { ... }

if isMenuItemPresented {
    MyMenuItemList()
}
```

## Sending location

To send a location, you can use the `LocationSelector` component, which presents a UI for the user to select a location. When the user taps the send location button, the `onSend` action of the `MessageField` is called.

> **NOTE:** 
>
> If you want to use `sendMessagePublisher` instead `onSend`, please refer to [Sending a new message by using publisher](https://www.notion.so/ChatUI-ab3dddb98c44434d993c96ae9da6b929#d918e619224147958c840e678c93890a)

```swift
@State private var showsLocationSelector: Bool = false

var body: some View {
    LocationSelector(isPresented: $showsLocationSelector)
}
```

## Sending a new message by using publisher

```swift
public var sendMessagePublisher: PassthroughSubject<MessageStyle, Never>
```

`sendMessagePublisher` is a Combine `Publisher` that passes `MessageStyle` object.

### How to publish

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

### How to subscribe

You can subscribe to `sendMessagePublisher` to handle new messages.

```swift
.onReceive(sendMessagePublisher) { messageStyle in
    // Handle `messageStyle` here (e.g., sending message with the style)
}
```

### Use cases
- rating system
- answering by defined message

- - -
