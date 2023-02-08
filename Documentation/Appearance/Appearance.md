#  Appearance

The `Appearance` struct represents a set of predefined appearances used in the app's user interface such as colors and typography. 
Use these colors to maintain consistency and familiarity in the user interface.

## Example Usage
```swift
@Environment(\.appearance) var appearance

var body: some View {
   Text("New Chat")
       .font(appearance.title)
       .foregroundColor(appearance.primary)
}
```

## Customization
```swift
let appearance = Appearance(tint: .orange)

var body: some View {
   ChatView()
       .environment(\.appearance, appearance)
}
```


