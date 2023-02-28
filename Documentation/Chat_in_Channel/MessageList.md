# MessageList

## Lists messages in row contents

In the intializer, you can list message objects that conform to `MessageProtocol` to display messages using the `rowContent` parameter.

All the body and row contents are flipped vertically so that new messages can be listed from the bottom.

The messages are listed in the following order, depending on the `readReceipt` value of the `MessageProtocol`. For more details, please refer to `MessageProtocol/readReceipt` or `ReadReceipt`.

> **NOTE:** The order of the messages is like below:
>
> sending → failed → sent → delivered → seen

## Scrolls to bottom

When a new message is sent or the scroll button is tapped, the view automatically scrolls to the bottom. You can also scroll the message list in other situations using the `scrollDownPublisher` by subscribing to it. See the following examples for how to use it.

### How to publish

```swift
let _ = Empty<Void, Never>()
    .sink(
        receiveCompletion: { _ in
            scrollDownPublisher.send(())
        },
        receiveValue: { _ in }
    )
```

### How to subscribe

```swift
.onReceive(scrollDownPublisher) { _ in
    withAnimation {
        scrollView.scrollTo(id, anchor: .bottom)
    }
}
```

## How to handle the keyboard visibilty

### Keyboard Visibility Publisher

`keyboardVisibilityPublisher` sends a boolean value that uses to show/hide keyboard.

`.keyboardVisibility(_:)` method: 
- sends the `Visibility` value via `keyboardVisibilityPublisher` just one time to change the keyboard visibility state.
- receives `keyboardVisibilityPublisher` events, use `keyboardReader()` modifier.

This examples shows a view that sends the `true` via `keyboardVisibility` publisher to shows keyboard and shows keyboard. 

```swift
SomeView()
    // Show up keyboard
    .keyboardVisibility(.visible)
```
When you want to receive event only, not send, assign `.automatic` to the parameter(`visibility`).
This examples shows a view that only receives `keyboardVisibilityPublisher` events.

```swift
SomeView()
    .keyboardVisibility(.automatic)
```

> **Recommendation:**
> It's' recommended that use `onReceive(_:perform:)` together to receives `keyboardNotificationPublisher` event when use this method.

```swift
@State var isKeyboardShown: Bool = false
     
var body: some View {
    SomeView()
        .keyboardVisibility(isKeyboardShown ? .visible : .hidden)
        .onReceive(keyboardNotificationPublisher) { value in
            isKeyboardShown = value
        }
    }
}
```

### Keyboard Notification Publisher

`keyboardVisibilityPublisher` sends the current status of keyboard visibility.

When `UIResponder.keyboardWillShowNotification` notification is called, it sends `true`.
When `UIResponder.keyboardWillHideNotification` notification is called, it sends `false`.

This examples shows how to receive the publisher event and handle the delivered value.

```swift
@State private isKeyboardShown: Bool = false

var body: some View {
    SomeView(isKeyboardShown: $isKeyboardShown)
        .onReceive(keyboardNotificationPublisher) { isShown in
            isKeyboardShown = isShown
        }
```
