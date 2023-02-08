#  Image Scales

This Swift extension provides convenient properties to scale `Image`
 views to predefined sizes. The `scale(_:contentMode:)`
 method is used to resize an image or other view to a specific size while keeping its aspect ratio.

## Properties

| Property Name | Size | Content Mode |
| --- | --- | --- |
| xSmall | 16 x 16 | .fit |
| xSmall2 | 16 x 16 | .fill |
| small | 20 x 20 | .fit |
| small2 | 20 x 20 | .fill |
| medium | 24 x 24 | .fit |
| medium2 | 24 x 24 | .fill |
| large | 36 x 36 | .fit |
| large2 | 36 x 36 | .fill |
| xLarge | 48 x 48 | .fit |
| xLarge2 | 48 x 48 | .fill |
| xxLarge | 64 x 64 | .fit |
| xxLarge2 | 64 x 64 | .fill |
| xxxLarge | 90 x 90 | .fit |
| xxxLarge2 | 90 x 90 | .fill |

## Method

```swift
func scale(_ scale: CGSize, contentMode: ContentMode) -> some View

```

**Description**

Scales the view to the specified size while maintaining its aspect ratio.

Use this method to resize an image or other view to a specific size while keeping its aspect ratio.

**Parameters**

| Parameter | Description |
| --- | --- |
| scale | The target size for the view, specified as a CGSize. |
| contentMode | The content mode to use when scaling the view. The default value is ContentMode.aspectFit. |

**Return Value**

A new view that scales the original view to the specified size.

**Example Usage**

```swift
Image("my-image")
    .scale(CGSize(width: 100, height: 100), contentMode: .fill)
```

In this example, the Image view is scaled to a size of `100` points by `100` points while maintaining its aspect ratio. The `contentMode` parameter is set to `.fill`, which means that the image is stretched to fill the available space, possibly cutting off some of the edges.

