![Frame 1 (2)](https://user-images.githubusercontent.com/53814741/221372100-95787895-c183-40e8-ab54-ec2d9598de62.png)

ChatUI is an open-source Swift package that provides a simple and reliable solution for implementing chat interfaces using SwiftUI.

[![stability-beta](https://img.shields.io/badge/stability-beta-33bbff.svg?style=for-the-badge)](https://github.com/mkenney/software-guides/blob/master/STABILITY-BADGES.md#beta)

## **Overview**

*written by ChatGPT*

There are many companies that provide Chat SDK, such as Firebase, Sendbird, GetStream, and Zendesk. This means that the interface we use to implement chat functionality depends on our choice of SDK. While Apple's UI framework, SwiftUI, allows for incredibly flexible and fast UI design, there is a lack of available information on how to implement chat functionality, particularly when it comes to managing scrolling in message lists. To solve this problem, some Chat SDK companies offer their own Chat UI kits. However, since one UIKit only supports one SDK, there is no guarantee that a given UIKit will support the Chat SDK we are using, and switching to a different Chat SDK can create significant UI issues.

Nevertheless, you know that different Chat SDKs essentially have the same meaning and essence despite different interface names and forms. If you conform to the protocols provided by ChatUI for the channels, messages, and users that we want to implement UI for, ChatUI can draw a SwiftUI-based chat UI based on this information.

<p align="center">
 <img src="https://user-images.githubusercontent.com/53814741/220272403-c22e6f03-6ced-4a19-a06c-c4e783decf07.png" width="20%"/>
 <img src="https://user-images.githubusercontent.com/53814741/220272270-36425ab7-93ec-4c27-a884-74498b3966db.png" width="20%"/>
 <img src="https://user-images.githubusercontent.com/53814741/220272356-4299c795-2219-410a-a7a1-c38427709ace.png" width="20%"/>
</p>

Although ChatUI currently offers very limited features, I’m confident that it can provide best practices for implementing chat interfaces using SwiftUI. Additionally, since ChatUI is an open source project, you can expand its capabilities and create a more impressive ChatUI together through contributions. I appreciate your interest.

> **Note**
> To see **Quickstart** or **Real use cases examples** projects, please go to [ChatUI-examples](https://github.com/jaesung-0o0/ChatUI-examples)

> **Note**
> To see **Figma**, the design resources, please see [ChatUI - Figma Community](https://www.figma.com/community/file/1211259538649728876)

> **Note**
> To see **ChatUI Canvas** app that allows to create view using ChatUI *without any code*, please see [Discussion - 🎉 ChatUI Canvas starts beta testing!](https://github.com/jaesung-0o0/ChatUI/discussions/5)

## **Contribution**

I welcome and appreciate contributions from the community. If you find a bug, have a feature request, or want to contribute code, please submit an issue or a pull request on our GitHub repository freely.

Please see [💪 How to Contribute](https://github.com/jaesung-0o0/ChatUI/discussions/1) in Discussion tab.

> **Important**
>
> When you contribute code via pull request, please add the <i>executable</i> <b>previews</b> that conforms to `PreviewProvider`.

## **License**

ChatUI is released under the MIT license. See **[LICENSE](https://github.com/jaesung-0o0/ChatUI/blob/main/LICENSE)** for details.

## **Installation**

To use ChatUI in your project, follow these steps:

1. In Xcode, select **File** > **Swift Packages** > **Add Package Dependency**.
2. In the search bar, paste the ChatUI URL: **[https://github.com/jaesung-0o0/ChatUI](https://github.com/jaesung-0o0/ChatUI)**
3. Select the branch as **main** to install.
4. Click **Next**, and then click **Finish**.

## **Usage**

To use ChatUI in your project, add the following import statement at the top of your file:

```swift
import ChatUI
```

You can then use ChatUI to implement chat interfaces in your SwiftUI views. Follow the guidelines in the ChatUI documentation to learn how to use the package.

### Real Use-cases Examples

To see **Quickstart** or **Real use cases examples** projects, please go to [ChatUI-examples](https://github.com/jaesung-0o0/ChatUI-examples)

### Design Resources

To see **Figma**, the design resources, please see [ChatUI - Figma Community](https://www.figma.com/community/file/1211259538649728876)

## Key Functions

### Chat in Channels

| Name | Description | Documentation |
| --- | --- | --- |
| ℹ️ Channel Info View | This is a view that displays the following channel information | [See documentation](/Documentation/Chat_in_Channel/ChannelInfoView.md) |
| 🥞 Message List | This is a view that lists message objects. | [See documentation](/Documentation/Chat_in_Channel/MessageList.md) | 
| 💬 Message Row | This is a view that is provided by default in ChatUI to display message information. | [See documentation](/Documentation/Chat_in_Channel/MessageRow.md) |
| ⌨️ Message Field | The message field is a UI component for sending messages | [See documentation](/Documentation/Chat_in_Channel/MessageField.md) |

### List Channels 

*Coming soon*

### Appearances

| Name | Description | Documentation |
| --- | --- | --- |
| Appearance | The `Appearance` struct represents a set of predefined appearances used in the app's user interface such as colors and typography. | [See documentation](/Documentation/Appearance/Appearance.md) |
| Colors | The predefined colors used in the ChatUI. | [See documentation](/Documentation/Appearance/Colors.md) |
| Typography | The predefined colors used in the ChatUI. | [See documentation](/Documentation/Appearance/Typography.md) |
| Images | The predefined images used in the ChatUI as an extension of the `SwiftUI.Image`. | [See documentation](/Documentation/Appearance/Images.md) |
| Image Scales | The predefined image scales used in the ChatUI. | [See documentation](/Documentation/Appearance/ImageScales.md) |

## To do list

### Features

If you have any feature you want, please let me know via *Issue* or *Discussion*

- [x]  MessageList: Dimiss keyboard when tap outside
- [ ]  MessageList: Date view
- [ ]  MessageList: Publisher for retrieving more message while scrolling
- [x]  MessageList: Message Menu 
- [x]  MessageList: Message reaction publisher 
- [ ]  MessageRow: placement (e.g., Both, leftOnly, rightOnly)
- [ ]  MessageField: CameraCapturer
- [ ]  Giphy: Resize body with GIF frame size
- [ ]  MapView: The view to shows map when the `.media(.location)` style message was tapped.
- [ ]  MediaView: The view to display / play media in message
- [ ]  MessageSearch: The feature that searches messages.

### Documentations

- [ ]  Code Style Convention
- [ ]  Issues Convention
- [ ]  Branch Convention (name, commit)
- [ ]  Pull Requests Convention (how to PR, review process)
