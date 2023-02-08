## Overview

*written by ChatGPT*

There are many companies that provide Chat SDK, such as Firebase, Sendbird, GetStream, and Zendesk. This means that the interface we use to implement chat functionality depends on our choice of SDK. While Apple's UI framework, SwiftUI, allows for incredibly flexible and fast UI design, there is a lack of available information on how to implement chat functionality, particularly when it comes to managing scrolling in message lists. To solve this problem, some Chat SDK companies offer their own Chat UI kits. However, since one UIKit only supports one SDK, there is no guarantee that a given UIKit will support the Chat SDK we are using, and switching to a different Chat SDK can create significant UI issues.

Nevertheless, you know that different Chat SDKs essentially have the same meaning and essence despite different interface names and forms. If you conform to the protocols provided by ChatUI for the channels, messages, and users that we want to implement UI for, ChatUI can draw a SwiftUI-based chat UI based on this information.

Although ChatUI currently offers very limited features, I’m confident that it can provide best practices for implementing chat interfaces using SwiftUI. Additionally, since ChatUI is an open source project, you can expand its capabilities and create a more impressive ChatUI together through contributions. I appreciate your interest.

## Key Functions

### Chat in Channels

#### ℹ️ Channel Info View
This is a view that displays the following channel information

[See documentation](/Documentation/Chat_in_Channel/ChannelInfoView.md)

#### 🥞 Message List
This is a view that lists message objects.

[See documentation](/Documentation/Chat_in_Channel/MessageList.md)

#### 💬 Message Row
This is a view that is provided by default in ChatUI to display message information.

[See documentation](/Documentation/Chat_in_Channel/MessageRow.md)

#### ⌨️ Message Field

The message field is a UI component for sending messages

[See documentation](/Documentation/Chat_in_Channel/MessageField.md)

### List Channels 

*Coming soon*

### Appearances

#### Appearance

The `Appearance` struct represents a set of predefined appearances used in the app's user interface such as colors and typography.

[See documentation](/Documentation/Appearance/Appearance.md)

#### Colors

The predefined colors used in the ChatUI.

[See documentation](/Documentation/Appearance/Colors.md)

#### Typography

The predefined colors used in the ChatUI.

[See documentation](/Documentation/Appearance/Typography.md)

#### Images

The predefined images used in the ChatUI as an extension of the `SwiftUI.Image`.

[See documentation](/Documentation/Appearance/Images.md)

#### Image Scales

The predefined image scales used in the ChatUI.

[See documentation](/Documentation/Appearance/ImageScales.md)
