#  Images

ChatUI provides image objects as an extension of the Image class in SwiftUI, where each image is created as a static variable with a default value being an image with a specific system name. These image names can be used to display icons, avatars, and other images. The names of these images can be used in the code to display the respective icon for various purposes in the user interface. 

| Property Name | Type | Default Value | Description |
| --- | --- | --- | --- |
| menu | Image | Image(systemName: "circle.grid.2x2.fill") | Icon for a menu |
| camera | Image | Image(systemName: "camera.fill") | Icon for a camera |
| photoLibrary | Image | Image(systemName: "photo") | Icon for a photo library |
| mic | Image | Image(systemName: "mic.fill") | Icon for a microphone |
| giphy | Image | Image(systemName: "face.smiling.fill") | Icon for GIPHY |
| send | Image | Image(systemName: "paperplane.fill") | Icon for sending a message |
| buttonHidden | Image | Image(systemName: "chevron.right") | Icon for a hidden button |
| directionDown | Image | Image(systemName: "chevron.down") | Icon for a downward direction |
| location | Image | Image(systemName: "location.fill") | Icon for a location |
| document | Image | Image(systemName: "paperclip") | Icon for a document |
| music | Image | Image(systemName: "music.note") | Icon for music |
| sending | Image | Image(systemName: "circle.dotted") | Icon for a message that is currently being sent |
| sent | Image | Image(systemName: "checkmark.circle") | Icon for a sent message |
| delivered | Image | Image(systemName: "checkmark.circle.fill") | Icon for a delivered message |
| failed | Image | Image(systemName: "exclamationmark.circle") | Icon for a failed message |
| downloadFailed | Image | Image(systemName: "icloud.slash") | Icon for a failed download |
| close | Image | Image(systemName: "xmark.circle.fill") | Icon for closing a window |
| flip | Image | Image(systemName: "arrow.triangle.2.circlepath") | Icon for flipping an object |
| delete | Image | Image(systemName: "trash") | Icon for deleting an object |
| pause | Image | Image(systemName: "pause.circle.fill") | Icon for pausing an activity |
| play | Image | Image(systemName: "play.circle.fill") | Icon for playing an activity |
| person | Image | Image(systemName: "person.crop.circle.fill") | Icon for a person |

The example usage in the code demonstrates how to use these images to display the send icon, by making the icon resizable, setting its size, and clipping it to a circle shape.

```swift
Image.send
    .resizable()
    .frame(width: 100, height: 100)
    .clipShape(Circle())
```
