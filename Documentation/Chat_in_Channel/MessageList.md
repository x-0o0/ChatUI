# MessageList

## Lists messages in row contents

In the constructor, you can list message objects that conform to `MessageProtocol` to display messages using the `rowContent` parameter.

All the body and row contents are flipped vertically so that new messages can be listed from the bottom.

The messages are listed in the following order, depending on the `readReceipt` value of the `MessageProtocol`. For more details, please refer to `MessageProtocol/readReceipt` or `ReadReceipt`.

sending → failed → sent → delivered → seen

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
